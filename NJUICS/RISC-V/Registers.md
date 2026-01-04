In 32-bit RISC-V, there are 32 general-purpose registers, named from `x0` to `x31`, and a Program Counter register. 

Note that the register `x0` is hard-wired to `0`, and registers `x1` to `x31` are all **general purposed**. 

However, the standard software calling convention uses register `x1` to hold the return address for a call, with register `x5` available as an alternate link register. The standard calling convention uses register `x2` as the stack pointer.

Hardware might choose to accelerate function calls and returns that use `x1` or `x5`. 