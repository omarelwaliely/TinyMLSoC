import yaml

def generate_verilog_wrapper(yaml_file, output_file):
    with open(yaml_file, 'r') as file:
        config = yaml.safe_load(file)
    
    # Extract the module name, defaulting to "wrapper" if not provided
    module_name = config.get("MODULE_NAME", "wrapper")
    
    # Extract registers
    regs = config.get("REGS", [])
    
    # Verilog code generation
    verilog_lines = []
    verilog_lines.append(f"module {module_name} (")
    
    # Generate ports dynamically based on YAML
    ports = []
    for reg in regs:
        name = reg.get("Name")
        size = reg.get("SIZE", 32)
        reg_type = reg.get("TYPE", "RW")
        
        if reg_type == "RO":
            ports.append(f"    output wire [{size-1}:0] {name}")
        elif reg_type == "RW":
            ports.append(f"    input wire [{size-1}:0] {name}_in")
            ports.append(f"    output wire [{size-1}:0] {name}_out")
    
    # Add common ports like `clk` and `reset` if specified
    common_ports = config.get("COMMON_PORTS", ["clk", "reset"])
    for port in common_ports:
        ports.insert(0, f"    input wire {port}")
    
    # Join ports with commas and add to module
    verilog_lines.append(",\n".join(ports))
    verilog_lines.append(");")
    verilog_lines.append("")
    
    # Register declarations
    verilog_lines.append("// Register Declarations")
    for reg in regs:
        if reg.get("REGISTERED", False):
            size = reg.get("SIZE", 32)
            name = reg.get("Name")
            verilog_lines.append(f"reg [{size-1}:0] {name}_reg;")
    
    verilog_lines.append("")
    
    # Register logic
    verilog_lines.append("// Register Logic")
    verilog_lines.append("always @(posedge clk or posedge reset) begin")
    verilog_lines.append("    if (reset) begin")
    for reg in regs:
        if reg.get("REGISTERED", False):
            size = reg.get("SIZE", 32)
            name = reg.get("Name")
            verilog_lines.append(f"        {name}_reg <= {size}'b0;")
    verilog_lines.append("    end else begin")
    for reg in regs:
        if reg.get("TYPE", "RW") == "RW" and reg.get("REGISTERED", False):
            name = reg.get("Name")
            verilog_lines.append(f"        {name}_reg <= {name}_in;")
    verilog_lines.append("    end")
    verilog_lines.append("end")
    verilog_lines.append("")
    
    # Output assignments
    verilog_lines.append("// Output Assignments")
    for reg in regs:
        name = reg.get("Name")
        reg_type = reg.get("TYPE", "RW")
        if reg_type == "RO":
            verilog_lines.append(f"assign {name} = {name}_reg;")
        elif reg_type == "RW":
            verilog_lines.append(f"assign {name}_out = {name}_reg;")
    
    verilog_lines.append("")
    verilog_lines.append("endmodule")
    
    # Write to output file
    with open(output_file, 'w') as file:
        file.write("\n".join(verilog_lines))
    
    print(f"Verilog wrapper generated and saved to {output_file}")


# Example usage:
yaml_file = "config.yaml"  # Replace with your YAML file path
output_file = "wrapper.v"  # Replace with your desired Verilog output file name
generate_verilog_wrapper(yaml_file, output_file)
