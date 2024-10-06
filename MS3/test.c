volatile unsigned int* gpio_data_A = (volatile unsigned int *) 0x40000000;
volatile unsigned int* gpio_oe_A = (volatile unsigned int *) 0x40000004;
volatile unsigned int* gpio_data_B = (volatile unsigned int *) 0x41000000;
volatile unsigned int* gpio_oe_B = (volatile unsigned int *) 0x41000004;
volatile unsigned int* gpio_data_C = (volatile unsigned int *) 0x42000000;
volatile unsigned int* gpio_oe_C = (volatile unsigned int *) 0x42000004;




int main() {

    *gpio_oe_A = 0x00000000;
    *gpio_oe_B = 0x00000000;
    *gpio_oe_C = 0xFFFFFFFF;
    
    unsigned int A_data = 0;
    unsigned int B_data = 0;


    while (1) { 

        A_data = *gpio_data_A;
        B_data = *gpio_data_B;
        *gpio_data_C = A_data + B_data;
        
    }

    return 0;
}