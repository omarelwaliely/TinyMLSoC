volatile unsigned int* gpio_data_A = (volatile unsigned int *) 0x40000000;
volatile unsigned int* gpio_oe_A = (volatile unsigned int *) 0x40000004;
volatile unsigned int* i2s_data = (volatile unsigned int *) 0x44000000;  

volatile unsigned int* TIMER_STATUS = (volatile unsigned int *) 0x43000000;
volatile unsigned int* LOAD_VALUE = (volatile unsigned int *) 0x43000004;

volatile unsigned int* uart_ctrl = (volatile unsigned int *) 0x50000000;
volatile unsigned int* uart_bauddiv = (volatile unsigned int *) 0x50000004;
volatile unsigned int* uart_status = (volatile unsigned int *) 0x50000008;
volatile unsigned int* uart_data = (volatile unsigned int *) 0x5000000C;

void delay(unsigned int milliseconds) {
    *LOAD_VALUE = milliseconds* 6000; //6000 for 6MHz clock
    *TIMER_STATUS = 0x0000001;
    while ((*TIMER_STATUS & 0x100) == 0) {

    }
}
void uart_init(int bauddiv){
    *uart_bauddiv = bauddiv;
    *uart_ctrl = 1;
}

void uart_putc(char c){
    while(*uart_status == 0);
    *uart_data = c;
    *uart_ctrl |= 2;
}

void uart_puts(char *s){
    for(int i=0; s[i]; i++)
        uart_putc(s[i]);
}


void uart_puts_int(int num) {
    for (int i = 3; i >= 0; i--) {
        char byte = (num >> (i * 8)) & 0xFF;
        uart_putc(byte);
    }
}

// void exit(){
//     *gpio_data = 0xF00FE00E;
// }

int main(){     
    
    *gpio_oe_A = 0xFFFFFFFF;  // configure the GPIO as an output
    // unsigned int data_A = 0xFFFF;    
    uart_init(625);
    while(1)
    {
        uart_putc('H');
        volatile data = *i2s_data;
        uart_puts_int(data);
    // if((data_A & 0x7) == 0b001)
    // uart_puts("I'm red!\n");
    // else if((data_A & 0x7) == 0b010)
    // uart_puts("I'm blue!\n");
    // else if((data_A & 0x7) == 0b011)
    // uart_puts("I'm purple!\n");
    // else if((data_A & 0x7) == 0b100)
    // uart_puts("I'm green!\n");
    // else if((data_A & 0x7) == 0b101)
    // uart_puts("I'm yellow!\n");
    // else if((data_A & 0x7) == 0b110)
    // uart_puts("I'm aqua!\n");
    // else if((data_A & 0x7) == 0b000)
    // uart_puts("I'm black:(\n");
    // else if((data_A & 0x7)== 0b111)
    // uart_puts("I'm white!\n");
    }
    return 0;
}

// void delay(void) {
//     unsigned int count = 500000;
//     while (count > 0) {
//         count--;
//     }
// }

// int main() {
//     *gpio_oe_A = 0xFFFFFFFF;  // Set GPIO as output
//     int data = *i2s_data;
//     // unsigned int sound_detected;
//     while (1) {
//         sound_detected = *i2s_data;  // Read data from the microphone

//         if (sound_detected > 100) { 
//             *gpio_data_A = 0b001;  // Green LED
//         } else {
//             *gpio_data_A = 0b100;  // Red LED
//         }

//         delay();
//     }

//     return 0;
// }


// volatile unsigned int* gpio_data_A = (volatile unsigned int *) 0x40000000;
// volatile unsigned int* gpio_oe_A = (volatile unsigned int *) 0x40000004;
// volatile unsigned int* mode = (volatile unsigned int *) 0x44000000;

// void send_data_bit_by_bit(unsigned int data) {
//     for (int i = 0; i < 32; i++) {
//         unsigned int bit = (data >> i) & 0x1; 
//         *gpio_data_A = (bit & 0x1); 
//     }
// }

// int main() { 
//     *mode = 2; //stereo
//     *gpio_oe_A = 0x00000008;  // Configure only the 4th bit of the GPIO as an output

//     unsigned int data_A_left = 0x00000000;  
//     unsigned int data_A_right = 0x00000000; 
//     unsigned int ws = 0;  

//     while (1) {
//         ws = (*gpio_data_A >> 3) & 0x1;  

//         if (ws == 0) {  
//             data_A_left = 0xABAAAAAA;  
//             send_data_bit_by_bit(data_A_left);  
//         } else {  
//             data_A_right = 0xABBBBBBB;
//             send_data_bit_by_bit(data_A_right); 
//         }
//     }

//     return 0;
// }
