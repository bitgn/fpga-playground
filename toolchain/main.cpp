// Wrapper for (System)Verilog, SystemC/C/C++ & simulator
// * simulator boiler-plate (i.e. drive reset/clk)
// * process/passthru cmdline args (i.e. wrapper args, plus args)
// TODO:
// * randomization/determinism (i.e. seed initialization)

#include "Vtop.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

vluint64_t main_time = 0;
vluint64_t sim_time = 1000;

// Called by $time in Verilog
// converts to double, to match
// what SystemC does
double sc_time_stamp () {
    return main_time;
}

int main(int argc, char** argv, char** env) {
    Verilated::commandArgs(argc, argv);
    Vtop* top = new Vtop;

    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);  // Trace 99 levels of hierarchy
    tfp->open("obj_dir/data.vcd");
    
    while (sc_time_stamp() < sim_time && !Verilated::gotFinish()) {
        top->reset = (main_time < 5) ? 1 : 0;
        top->clk = main_time % 2;
        top->enable = 1;
        top->eval();
        tfp->dump(main_time);
        main_time++;
    }
    top->final();
    delete top;
    tfp->close();
    exit(0);
}
