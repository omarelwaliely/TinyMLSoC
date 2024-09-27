volatile unsigned int* gpio_data = (volatile unsigned int *) 0x40000000;
volatile unsigned int* gpio_oe = (volatile unsigned int *) 0x40000004;

int main(){
    // configure the GPIO as an output
    *gpio_oe = 0xFFFFFFFF;
    // output something
    *gpio_data = 0xF00FE00E;
    return 0;
}