volatile unsigned int* gpio_data_A = (volatile unsigned int *) 0x40000000;
volatile unsigned int* gpio_oe_A = (volatile unsigned int *) 0x40000004;

volatile unsigned int* i2s_en = (volatile unsigned int*) 0x44000000;
volatile unsigned int* i2s_done = (volatile unsigned int*) 0x44000004;
volatile unsigned int* i2s_data = (volatile unsigned int*) 0x44000008;
volatile unsigned int* i2s_fifo_status = (volatile unsigned int*) 0x4400000C;
volatile unsigned int* i2s_fifo_data = (volatile unsigned int*) 0x44000010;



volatile unsigned int* TIMER_STATUS = (volatile unsigned int *) 0x43000000;
volatile unsigned int* LOAD_VALUE = (volatile unsigned int *) 0x43000004;

volatile unsigned int* uart_ctrl = (volatile unsigned int *) 0x80000000;
volatile unsigned int* uart_bauddiv = (volatile unsigned int *) 0x80000004;
volatile unsigned int* uart_status = (volatile unsigned int *) 0x80000008;
volatile unsigned int* uart_data = (volatile unsigned int *) 0x8000000C;

volatile int flag = 0;
void enable_IRQ(void);
void uart_putc(char c);
void uart_puts_hex(int num);

void enable_IRQ(void){
    asm volatile("csrw mtvec, %0" :: "r"(0x00000400)); //set machine trap base to 0x00000400 makes it go to that address on interrupt, in the linker script I set the function for isr to that register, in other words on Interrupt go to the ISR function
    asm volatile("csrsi mstatus, 0x8"); //this is to enable global inerrupts
    asm volatile("csrsi mie, 0x8");      //I dont know if this line is needed but it enables "external" interrupts

}
void return_m(void){
    asm volatile("mret");
}

__attribute__((section(".isr_handler_section"))) void isr_handler(void) {
    flag = 1;    
    return_m();

}

void delay(unsigned int milliseconds) {
    *LOAD_VALUE = milliseconds * 6000; // 6000 for 6MHz clock
    *TIMER_STATUS = 0x0000001;
    while ((*TIMER_STATUS & 0x100) == 0) {

    }
}

void uart_init(int bauddiv) {
    *uart_bauddiv = bauddiv;
    *uart_ctrl = 1;
}

void uart_putc(char c) {
    while (*uart_status == 0);
    *uart_data = c;
    *uart_ctrl |= 2;
}

void uart_puts(char *s) {
    for (int i = 0; s[i]; i++)
        uart_putc(s[i]);
}

void uart_puts_hex(int num) {
    char hex_string[11]; // 8 characters for 32-bit hex + \r + \n + null terminator
    for (int i = 0; i < 8; i++) {
        int nibble = (num >> (28 - 4 * i)) & 0xF; // Extract each hex nibble
        if (nibble < 10) {
            hex_string[i] = '0' + nibble; // 0-9
        } else {
            hex_string[i] = 'A' + (nibble - 10); // A-F
        }
    }
    hex_string[8] = '\r'; // Carriage return
    hex_string[9] = '\n'; // Newline
    hex_string[10] = '\0'; // Null terminator

    uart_puts(hex_string); // Send the hex string with UART
}

unsigned int reverse_bits(unsigned int num) {
    unsigned int reversed = 0;
    for (int i = 0; i < 32; i++) {
        reversed |= ((num >> i) & 0x1) << (31 - i);
    }
    return reversed;
}

int main() {
    enable_IRQ();
    volatile int add = 0x00000009;
   *i2s_en = add;
    uart_init(625);         // Initialize UART with a baud rate setting

    volatile unsigned int x;
    volatile char c1, c2;
                  *gpio_data_A = 3;

    while (1) {
        while (*i2s_done != 0x00000003);
          x = *i2s_data;
              *gpio_data_A = x;
            uart_putc('g');
        // if(flag){
        //     while(*i2s_fifo_status != 0x00000001){
        //         x = *i2s_fifo_data;
        //         uart_puts_hex(x);
        //     }
        //     flag = 0;
        // }
    }
    return 0;
}