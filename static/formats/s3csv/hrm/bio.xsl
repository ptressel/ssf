<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:hrm="http://eden.sahanafoundation.org/org">

    <!-- **********************************************************************
        Bio - CSV Import Stylesheet

         - example raw URL usage:
           Let URLpath be the URL to Sahana Eden appliation
           Let Resource be hrm/competency_rating/create
           Let Type be s3csv
           Let CSVPath be the path on the server to the CSV file to be imported
           Let XSLPath be the path on the server to the XSL transform file
           Then in the browser type:

        Column headers looked up in labels.xml:

        CSV fields:
        First Name......................................pr_person.first_name
        Last Name.......................................pr_person.first_name
        Sex.............................................pr_person.sex
        Email...........................................pr_contact.value
        Short Bio.......................................hrm_bio.short_bio
        Long Bio........................................hrm_bio.long_bio

    *********************************************************************** -->
    <xsl:output method="xml"/>
    <xsl:include href="./person.xsl"/>

    <!-- ****************************************************************** -->
    <xsl:template match="/">
        <s3xml>
            <!-- Process all table rows for person records -->
            <xsl:apply-templates select="table/row"/>
        </s3xml>

    </xsl:template>

    <!-- ****************************************************************** -->
    <!-- Person Record -->
    <xsl:template match="row">

        <xsl:variable name="gender">
            <xsl:call-template name="GetColumnValue">
                <xsl:with-param name="colhdrs" select="$PersonGender"/>
            </xsl:call-template>
        </xsl:variable>

        <resource name="hrm_bio">
            <data field="short_bio"><xsl:value-of select="col[@field='Short Bio']"/></data>
            <data field="long_bio"><xsl:value-of select="col[@field='Long Bio']"/></data>
            <reference field="person_id" resource="pr_person">
                <resource name="pr_person">
                    <data field="first_name"><xsl:value-of select="col[@field='First Name']"/></data>
                    <data field="last_name"><xsl:value-of select="col[@field='Last Name']"/></data>
                    <xsl:if test="$gender!=''">
                        <data field="gender">
                            <xsl:attribute name="value"><xsl:value-of select="$gender"/></xsl:attribute>
                        </data>
                    </xsl:if>
                    <xsl:call-template name="ContactInformation"/>
                </resource>
            </reference>
        </resource>

    </xsl:template>

    <!-- ****************************************************************** -->

</xsl:stylesheet>
