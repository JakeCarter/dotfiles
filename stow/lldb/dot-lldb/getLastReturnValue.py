#!/usr/bin/python

import lldb

def getLastReturnValue(debugger, command, exe_ctx, result, internal_dict):
    """Retrieve the last value returned by a function call on this thread."""

    returnValue = exe_ctx.thread.GetStopReturnValue()
    T = returnValue.GetType().GetName()
    N = returnValue.GetName()
    V = returnValue.GetValue()
    S = returnValue.GetSummary()
    value = S if S else V if V else ""
    print("({type}) {name} = {value}".format(type=T, name=N, value=value), file=result)


def __lldb_init_module(debugger, *args):
    debugger.HandleCommand('command script add -f getLastReturnValue.getLastReturnValue getreturn')
    print('The "getreturn" python command has been installed and is ready for use.')
