//volatile unsigned int* gpio_data_A = (volatile unsigned int *) 0x40000000;
//volatile unsigned int* gpio_oe_A = (volatile unsigned int *) 0x40000004;

volatile unsigned int* i2s_en = (volatile unsigned int*) 0x44000000;
volatile unsigned int* i2s_done = (volatile unsigned int*) 0x44000004;
volatile unsigned int* i2s_data = (volatile unsigned int*) 0x44000008;

volatile unsigned int* TIMER_STATUS = (volatile unsigned int *) 0x43000000;
volatile unsigned int* LOAD_VALUE = (volatile unsigned int *) 0x43000004;

volatile unsigned int* uart_ctrl = (volatile unsigned int *) 0x50000000;
volatile unsigned int* uart_bauddiv = (volatile unsigned int *) 0x50000004;
volatile unsigned int* uart_status = (volatile unsigned int *) 0x50000008;
volatile unsigned int* uart_data = (volatile unsigned int *) 0x5000000C;

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


int main() {
   *i2s_en = 0x00000009;
    uart_init(3);         // Initialize UART with a baud rate setting

    volatile int x;
    volatile char c1, c2;
    // uart_putc('h');
    // uart_putc('h');
    while (1) {
        if (*i2s_done == 0x00000003){
            uart_putc('h');
        }
        else{
            uart_putc('c');
        }

        // x = *i2s_data;

        //c1 = (x >> 24) & 0xFF;
        //c2 = (x >> 16) & 0xFF;
        //uart_puts_hex(x);
        //uart_putc('h'); 
        //uart_putc('h'); 
    }
    return 0;
}