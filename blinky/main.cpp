#include "Vtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

vluint64_t main_time = 0;
vluint64_t sim_time = 1000;


int main(int argc, char** argv, char** env) {
    Verilated::commandArgs(argc, argv);
    Vtop* top = new Vtop;

    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);  // Trace 99 levels of hierarchy
    tfp->open("obj_dir/data.vcd");
    
    while (main_time < sim_time && !Verilated::gotFinish()) {
        top->clk = main_time % 2;
        top->eval();
        tfp->dump(main_time);
        main_time++;
    }
    top->final();
    delete top;
    tfp->close();
    exit(0);
}
