volatile unsigned int* gpio_data_1 = (volatile unsigned int *) 0x40000000;
volatile unsigned int* gpio_oe_1 = (volatile unsigned int *) 0x40000004;
volatile unsigned int* gpio_data_2 = (volatile unsigned int *) 0x80000000;
volatile unsigned int* gpio_oe_2 = (volatile unsigned int *) 0x80000004;
volatile unsigned int* gpio_data_3 = (volatile unsigned int *) 0xc0000000;
volatile unsigned int* gpio_oe_3 = (volatile unsigned int *) 0xc0000004;

int main() {
    *gpio_oe_1 = 0x00000000;  
    *gpio_oe_2 = 0x00000000;  
    *gpio_oe_3 = 0xFFFFFFFF;  

    unsigned int test_cases[][2] = {
        {0x00000010, 0x00000002}, 
        {0x00000020, 0x00000003}, 
        {0x00000030, 0x00000004}, 
        {0x00000040, 0x00000005}, 
        {0x00000050, 0x00000006}, 
        {0x00000060, 0x00000007} 
    };

    int num_cases = sizeof(test_cases) / sizeof(test_cases[0]);

    for (int i = 0; i < num_cases; i++) {
        *gpio_data_1 = test_cases[i][0];
        *gpio_data_2 = test_cases[i][1];
        
        *gpio_data_3 = *gpio_data_1 + *gpio_data_2;
       
    }

    return 0;
}
