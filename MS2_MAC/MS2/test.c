volatile unsigned int* gpio_data = (volatile unsigned int *) 0x40000000;
volatile unsigned int* gpio_oe = (volatile unsigned int *) 0x40000004;
volatile unsigned int* test = (volatile unsigned int *) 0x40000008;


int main(){
    // configure the GPIO as an output
    *gpio_oe = 0xFFFFFFFF;
    // output something
    *gpio_data = 0xF00FE000;
    *test = 0xF00FE003;
    return 0;
}