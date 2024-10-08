volatile unsigned int* gpio_data_A = (volatile unsigned int *) 0x40000000;
volatile unsigned int* gpio_oe_A = (volatile unsigned int *) 0x40000004;
// volatile unsigned int* gpio_data_B = (volatile unsigned int *) 0x41000000;
// volatile unsigned int* gpio_oe_B = (volatile unsigned int *) 0x41000004;
// volatile unsigned int* gpio_data_C = (volatile unsigned int *) 0x42000000;
// volatile unsigned int* gpio_oe_C = (volatile unsigned int *) 0x42000004;




int main() {

    *gpio_oe_A = 0xFFFFFFFF;



    while (1) { 
        *gpio_data_A= 0xFFF1;
        
    }

    return 0;
}