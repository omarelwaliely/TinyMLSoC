volatile unsigned int* gpio_data_A = (volatile unsigned int *) 0x40000000;
volatile unsigned int* gpio_oe_A = (volatile unsigned int *) 0x40000004;
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

int main(){     
    
    while(1)
    {
    delay(1);
    }
    return 0;
}