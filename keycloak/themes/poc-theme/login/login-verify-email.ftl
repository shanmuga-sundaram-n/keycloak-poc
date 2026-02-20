<#import "template.ftl" as layout>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${msg("emailVerifyTitle")}</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${url.resourcesPath}/css/header.css">
    <link rel="stylesheet" href="${url.resourcesPath}/css/login.css">
</head>
<body>
    <nav class="site-header">
        <span class="site-header-brand">${realm.displayName!"Keycloak POC"}</span>
        <div class="site-header-auth">
            <a href="${url.loginUrl}" class="nav-btn">Login</a>
            <#if realm.registrationAllowed>
                <a href="${url.registrationUrl}" class="nav-btn nav-btn-primary">Register</a>
            </#if>
        </div>
    </nav>

    <div class="kc-main">
        <div class="kc-card kc-info-card">
            <div class="kc-icon">&#9993;</div>
            <h1 class="kc-card-title">${msg("emailVerifyTitle")}</h1>
            <p>${msg("emailVerifyInstruction1")}</p>
            <p>${msg("emailVerifyInstruction2")}</p>
            <p>${msg("emailVerifyInstruction3")}</p>

            <#if message?has_content>
                <div class="alert alert-${message.type}">
                    ${kcSanitize(message.summary)?no_esc}
                </div>
            </#if>

            <a href="${url.loginAction}" class="btn btn-primary" style="margin-top: 20px; display: inline-flex;">
                ${msg("doClickHere")}
            </a>
        </div>
    </div>
</body>
</html>
