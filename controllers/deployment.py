module = request.controller
resourcename = request.function

# =============================================================================
def index():
    """
        Application Home page
    """

    module_name = deployment_settings.modules[module].name_nice
    response.title = module_name

    table = s3db.cms_post
    item = db(table.module == module).select(table.body,
                                             limitby=(0, 1)).first()
    if item:
        item = item.body
    else:
        item = H2(module_name)

    # tbc
    report = ""

    return dict(item=item, report=report)

# -----------------------------------------------------------------------------
def deployment():
	 return s3_rest_controller()
