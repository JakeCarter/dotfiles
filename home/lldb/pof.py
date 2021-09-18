#!/usr/bin/python

import lldb
import re

def pof(debugger, command, result, internal_dict):
	usage = "usage: %prog <regex> -- <expression>"
	'''This command is meant to be used as po but with a regular expression to filter out lines of output.
	'''
	
	lastIndexOfDashDash = command.rfind('--')
	regexString = command[:lastIndexOfDashDash].strip(" ")
	exprString = command[lastIndexOfDashDash+2:].strip(" ")
	
	print('Filtering out lines that match %(regexString)s from the output of %(exprString)s' % {"regexString" : regexString, "exprString" : exprString})
	
	# re.search("^\[*\w*\s*\w*\]*", command)
	
	result = lldb.SBCommandReturnObject()
	commandInterpreter = debugger.GetCommandInterpreter()
	commandInterpreter.HandleCommand('expr -O -- %(exprString)s' % {"exprString" : exprString}, result)
	
	# TODO: Check return status from HandleCommand.
	
	# re.search("^foo", searchText, re.M)
	regex = re.compile(regexString)
	output = result.GetOutput()
	lines = output.split('\n')
	
	# filteredOutput = filter(regex.search, lines) #[line for line in lines if regex.search(line)]
	# filteredOutput = []
	for line in lines:
		# print 'Looking for %(regexString)s in "%(line)s"...' % {"regexString" : regexString, "line" : line}
		if regex.search(line):
			print('%(line)s\n' % {"line" : line})
		
	# return 0
	
	# print filteredOutput
	
	
	# print 'Output contains %(count)s lines' % {"count" : len(lines)}
	# # print output
	# for line in lines[:]:
	# 	print line
	
def __lldb_init_module(debugger, internal_dict):
	debugger.HandleCommand('command script add -f pof.pof pof')
	print('The "pof" python command has been installed and is ready for use.')
