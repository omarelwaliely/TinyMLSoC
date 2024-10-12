volatile unsigned int* gpio_data_A = (volatile unsigned int *) 0x40000000;
volatile unsigned int* gpio_oe_A = (volatile unsigned int *) 0x40000004;
volatile unsigned int* TIMER_STATUS = (volatile unsigned int *) 0x43000000;
volatile unsigned int* LOAD_VALUE = (volatile unsigned int *) 0x43000004;

void delay(unsigned int milliseconds) {
    *LOAD_VALUE = milliseconds* 6000; //6000 for 6MHz clock
    *TIMER_STATUS = 0x0000001;
    while ((*TIMER_STATUS & 0x100) == 0) {

    }
}

int main() {

    *gpio_oe_A = 0xFFFFFFFF;
    unsigned int data_A = 0xFFFF;    
    while (1) { 
        *gpio_data_A = data_A;
        data_A = (data_A +1)% 7;
        delay(1000);
    }

    return 0;
}