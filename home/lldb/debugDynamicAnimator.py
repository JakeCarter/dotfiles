#!/usr/bin/python

import lldb

def debugDynamicAnimator(debugger, command, exe_ctx, result, internal_dict):
	"""Uses the private setter `setDebugEnabled:` on a UIDynamicAnimator. Need to have a local variable named `a` that contains a pointer to a UIDynamicAnimator. Useful in breakpoint commands with 'Auto continue' turned on."""
	
	ci = debugger.GetCommandInterpreter()
	ro = lldb.SBCommandReturnObject()

	frame = exe_ctx.GetFrame()
	print >>result, "Got frame: {}".format(frame)
	
	animatorValue = frame.FindVariable("a")
	print >>result, "animator: {}".format(animatorValue)
	
	value = animatorValue.value
	print >>result, "value: {}".format(value)
	
	cmdString = "expr -l objc++ -- (void)[(UIDynamicAnimator *){} setDebugEnabled:1]".format(value)
	print >>result, "cmdString: {}".format(cmdString)
	
	ci.HandleCommand(cmdString, ro)	
	output = ro.GetOutput().strip()
	print >>result, "output: {}".format(output)

def __lldb_init_module(debugger, internal_dict):
	debugger.HandleCommand('command script add -f debugDynamicAnimator.debugDynamicAnimator dda')
	print('The "dda" python command has been installed and is ready for use.')
