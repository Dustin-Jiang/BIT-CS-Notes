The base RISC-V ISA has fixed-length **32-bit** instructions that must be naturally aligned on 32-bit
boundaries. 

However, the standard RISC-V encoding scheme is designed to support ISA extensions with variable-length instructions, where each instruction can be any number of 16-bit instruction parcels in length and parcels are naturally aligned on 16-bit boundaries. 

All the 32-bit instructions in the base ISA have their lowest two bits set to 11. The optional compressed 16-bit instruction-set extensions have their lowest two bits equal to 00, 01, or 10.

![[Little-endian]]

![[Instruction Formats]]

![[Instruction Abbreviations]]