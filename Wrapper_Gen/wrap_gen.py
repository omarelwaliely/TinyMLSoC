import yaml

def generate_verilog_wrapper(yaml_file, output_file):
    with open(yaml_file, 'r') as file:
        config = yaml.safe_load(file)

    module_name = config.get("MODULE_NAME", "wrapper")
    parameters = config.get("PARAMETERS", [])
    common_ports = config.get("COMMON_PORTS", [])
    regs = config.get("REGS", [])
    inputs = config.get("INPUTS", [])
    outputs = config.get("OUTPUTS", [])

    verilog_lines = []

    # Module Header
    verilog_lines.append(f"module {module_name} #(")
    for param in parameters:
        param_name = param["Name"]
        param_default = param.get("DEFAULT", "")
        verilog_lines.append(f"    parameter {param_name} = {param_default},")
    if parameters:
        verilog_lines[-1] = verilog_lines[-1][:-1]  # Remove trailing comma
    verilog_lines.append(")(")

    # Ports
    ports = []
    for port in common_ports:
        ports.append(f"    input wire {port}")
    for inp in inputs:
        size = inp['SIZE']
        size_str = f"[{size-1}:0] " if isinstance(size, int) else f"[{size}-1:0] "
        ports.append(f"    input wire {size_str}{inp['Name']}")
    for out in outputs:
        size = out['SIZE']
        size_str = f"[{size-1}:0] " if isinstance(size, int) else f"[{size}-1:0] "
        ports.append(f"    output wire {size_str}{out['Name']}")
    verilog_lines.extend(",\n".join(ports).splitlines())
    verilog_lines.append(");")
    verilog_lines.append("")

    # Parameterized Register Declarations
    verilog_lines.append("// Register Declarations")
    for reg in regs:
        size = reg["SIZE"]
        size_str = f"[{size-1}:0]" if isinstance(size, int) else f"[{size}-1:0]"
        verilog_lines.append(f"reg {size_str} {reg['Name']}_reg;")
    verilog_lines.append("")

    # Register Logic
    verilog_lines.append("// Register Logic")
    verilog_lines.append("always @(posedge clk or negedge rst_n) begin")
    verilog_lines.append("    if (!rst_n) begin")
    for reg in regs:
        verilog_lines.append(f"        {reg['Name']}_reg <= 0;")
    verilog_lines.append("    end else begin")
    for reg in regs:
        if reg["TYPE"] == "RW":
            verilog_lines.append(f"        {reg['Name']}_reg <= {reg['Name']};")
    verilog_lines.append("    end")
    verilog_lines.append("end")
    verilog_lines.append("")

    # Assignments for Outputs
    verilog_lines.append("// Output Assignments")
    for out in outputs:
        if out["Name"] in [reg["Name"] for reg in regs]:
            verilog_lines.append(f"assign {out['Name']} = {out['Name']}_reg;")
    verilog_lines.append("")

    # Endmodule
    verilog_lines.append("endmodule")

    # Write to File
    with open(output_file, 'w') as file:
        file.write("\n".join(verilog_lines))
    
    print(f"Verilog wrapper for {module_name} generated and saved to {output_file}.")

# Example usage
yaml_file = "i2s.yaml"  # Replace with the YAML file name
output_file = "i2s_wrapper.v"  # Replace with the desired Verilog file name
generate_verilog_wrapper(yaml_file, output_file)
