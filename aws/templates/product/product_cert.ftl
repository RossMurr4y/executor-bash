[#-- Certificate --]
[#if deploymentUnit?contains("cert")]
    [#assign certificateId = formatCertificateId(region, productDomainCertificateId)]
    [#switch productListMode]
        [#case "definition"]
            [@checkIfResourcesCreated /]
            "certificate" : {
                "Type" : "AWS::CertificateManager::Certificate",
                "Properties" : {
                    "DomainName" : "*.${productDomain}"
                    [#if productDomainValidation?has_content]
                        ,"DomainValidationOptions" : [
                            {
                                "DomainName" : "*.${productDomain}",
                                "ValidationDomain" : "${productDomainValidation}"
                            }
                        ]
                    [/#if]
                }
            }
            [@resourcesCreated /]
            [#break]

        [#case "outputs"]
            [@output "certificate" certificateId /]
            [#break]

    [/#switch]
[/#if]

