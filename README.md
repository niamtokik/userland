# OpenBSD userland in Mercury

This is a simple project to learn Mercury based on awesome OpenBSD
userland. The goal is to port all OpenBSD userland tool in Mercury and
add the same features (e.g. pledge).

This project is a strict mapping of the OpenBSD src. The same
directories are present, with same programs names. Only a few list of
directories present in root were added (e.g. `doc`).

## Side projects

 * Document Mercury: 
   * How to implement a C interface;
   * How to use thread;
   * How to implement low level feature.
   
 * Implement security features in Mercury.
 
 * Create unit and functional test for OpenBSD based on this new
   implementation.

 * Compare OpenBSD code with Mercury C generated one.
