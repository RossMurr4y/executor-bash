[#-- VPC --]

[#-- Resources --]

[#function formatSecurityGroupId ids...]
    [#return formatResourceId(
                "securityGroup",
                ids)]
[/#function]

[#function formatDependentSecurityGroupId resourceId extensions...]
    [#return formatDependentResourceId(
                "securityGroup",
                resourceId,
                extensions)]
[/#function]

[#-- Where possible, the dependent resource variant should be used --]
[#-- based on the resource id of the component using the security  --]
[#-- group. This avoids clashes where components has the same id   --]
[#-- but different types                                           --]
[#function formatComponentSecurityGroupId tier component extensions...]
    [#return formatComponentResourceId(
                "securityGroup",
                tier,
                component,
                extensions)]
[/#function]

[#function formatDependentComponentSecurityGroupId 
            tier
            component
            resourceId
            extensions...]
    [#local legacyId = formatComponentSecurityGroupId(
                        tier,
                        component,
                        extensions)]
    [#return getKey(legacyId)?has_content?then(
                legacyId,
                formatDependentSecurityGroupId(
                    resourceId,
                    extensions))]
[/#function]

[#function formatSecurityGroupIngressId ids...]
    [#return formatResourceId(
                "securityGroupIngress",
                ids)]
[/#function]

[#-- Use the associated security group where possible as the dependent --]
[#-- resource. (It may well in turn be a dependent resource)           --]
[#-- As nothing depends in ingress resources, Cloud Formation will     --]
[#-- deal with deleting the resource with the old format id.           --]
[#function formatDependentSecurityGroupIngressId resourceId extensions...]
    [#return formatDependentResourceId(
                "ingress",
                resourceId,
                extensions)]
[/#function]

[#function formatComponentSecurityGroupIngressId tier component extensions...]
    [#return formatComponentResourceId(
                "securityGroupIngress",
                tier,
                component,
                extensions)]
[/#function]

[#function formatVPCId]
    [#local legacyId = formatSegmentResourceId(
                "vpc",
                "vpc")]
    [#return getKey(legacyId)?has_content?then(
                legacyId,
                formatSegmentResourceId("vpc"))]
[/#function]

[#function formatVPCIGWId]
    [#local legacyId = formatSegmentResourceId(
                "igw",
                "igw")]
    [#return getKey(legacyId)?has_content?then(
                legacyId,
                formatSegmentResourceId("igw"))]
[/#function]

[#function formatVPCFlowLogsId extensions...]
    [#return formatDependentResourceId(
        formatSegmentResourceId("vpc"),
        "vpcflowlogs",
        extensions)]
[/#function]

[#-- Legacy functions reflecting inconsistencies in template id naming --]
[#function formatVPCTemplateId]
    [#local legacyId = formatSegmentResourceId(
                "vpc",
                "vpc")]
    [#return getKey(legacyId)?has_content?then(
                "vpc",
                formatSegmentResourceId("vpc"))]
[/#function]

[#function formatVPCIGWTemplateId]
    [#local legacyId = formatSegmentResourceId(
                "igw",
                "igw")]
    [#return getKey(legacyId)?has_content?then(
                "igw",
                formatSegmentResourceId("igw"))]
[/#function]

[#function formatSubnetId tier zone]
    [#return formatZoneResourceId(
            "subnet",
            tier,
            zone)]
[/#function]

[#-- Attributes --]


