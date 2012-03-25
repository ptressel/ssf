db.define_table("deployment_regs",Field("need_type",requires = IS_IN_SET(["Emergency", "Prepardness"])),
	Field("purpose","text",requires=IS_NOT_EMPTY()),	
	Field("start_date","date",requires=IS_NOT_EMPTY()),
	Field("end_date","date",requires=IS_NOT_EMPTY()),
	Field("site_url",requires=IS_NOT_EMPTY()),
	Field("site_owner",requires=IS_NOT_EMPTY()),
	Field("organisation_contact_info","text",requires=IS_NOT_EMPTY()),
	*s3_meta_fields())
