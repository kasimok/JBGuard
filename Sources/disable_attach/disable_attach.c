//
//  denyptrace.c
//  
//
//  Created by 0x67 on 2024-03-29.
//

#include "disable_attach.h"

#include <stdio.h>
#import <dlfcn.h>
#import <sys/types.h>

typedef int (*ptrace_ptr_t)(int _request, pid_t _pid, caddr_t _addr, int _data);
#if !defined(PT_DENY_ATTACH)
#define PT_DENY_ATTACH 31
#endif
void disable_gdb() {
  // dynamically loads the current process's symbol table.
  void* handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
  
  // looks up the ptrace symbol in the symbol table.
  ptrace_ptr_t ptrace_ptr = dlsym(handle, "ptrace");
  
  // calls ptrace with the PT_DENY_ATTACH request, which tells the system to not allow any process to attach to this one.
  ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
  
  // closes the handle to the symbol table.
  dlclose(handle);
}
