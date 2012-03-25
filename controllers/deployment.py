module = request.controller
resourcename = request.function

def regs():
	 return s3_rest_controller(module, resourcename)
