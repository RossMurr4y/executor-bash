[#-- KMS --]

[#assign CMK_OUTPUT_MAPPINGS =
    {
        REFERENCE_ATTRIBUTE_TYPE : {
            "UseRef" : true
        },
        ARN_ATTRIBUTE_TYPE : { 
            "Attribute" : "Arn"
        }
    }
]
[#assign outputMappings +=
    {
                CMK_RESOURCE_TYPE : CMK_OUTPUT_MAPPINGS
    }
]

[#macro createCMK mode id description statements rotateKeys=true outputId=""]
    [@cfResource
        mode=mode
        id=id
        type="AWS::KMS::Key"
        properties=
            {
                "Description" : description,
                "Enabled" : true,
                "EnableKeyRotation" : rotateKeys,
                "KeyPolicy" : getPolicyDocumentContent(statements)
            }
        outputs=CMK_OUTPUT_MAPPINGS
        outputId=outputId
    /]
[/#macro]

[#macro createCMKAlias mode id name cmkId]

    [@cfResource
        mode=mode
        id=id
        type="AWS::KMS::Alias"
        properties=
            {
                "AliasName" : name,
                "TargetKeyId" : getReference(cmkId, ARN_ATTRIBUTE_TYPE)
            }
        outputs={}
    /]
[/#macro]
