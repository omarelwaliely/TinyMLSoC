volatile unsigned int* gpio_data_A = (volatile unsigned int *) 0x40000000;
volatile unsigned int* gpio_oe_A = (volatile unsigned int *) 0x40000004;
volatile unsigned int* mode = (volatile unsigned int *) 0x44000000;

void send_data_bit_by_bit(unsigned int data) {
    for (int i = 0; i < 32; i++) {
        unsigned int bit = (data >> i) & 0x1; 
        *gpio_data_A = (bit & 0x1); 
    }
}

int main() { 
    *mode = 2; //stereo
    *gpio_oe_A = 0x00000008;  // Configure only the 4th bit of the GPIO as an output

    unsigned int data_A_left = 0x00000000;  
    unsigned int data_A_right = 0x00000000; 
    unsigned int ws = 0;  

    while (1) {
        ws = (*gpio_data_A >> 3) & 0x1;  

        if (ws == 0) {  
            data_A_left = 0xABAAAAAA;  
            send_data_bit_by_bit(data_A_left);  
        } else {  
            data_A_right = 0xABBBBBBB;
            send_data_bit_by_bit(data_A_right); 
        }
    }

    return 0;
}
