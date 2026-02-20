<#import "template.ftl" as layout>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${msg("emailForgotTitle")}</title>
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
        <div class="kc-card">
            <h1 class="kc-card-title">${msg("emailForgotTitle")}</h1>
            <p class="kc-card-subtitle">Enter your username or email and we'll send you instructions to reset your password.</p>

            <#if message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                <div class="alert alert-${message.type}">
                    ${kcSanitize(message.summary)?no_esc}
                </div>
            </#if>

            <form action="${url.loginAction}" method="post">
                <div class="form-group">
                    <label for="username">
                        <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
                    </label>
                    <input type="text" id="username" name="username" autofocus autocomplete="username"
                           class="<#if messagesPerField.existsError('username')>has-error</#if>">
                    <#if messagesPerField.existsError('username')>
                        <div class="field-error">${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}</div>
                    </#if>
                </div>

                <button type="submit" class="btn btn-primary">${msg("doSubmit")}</button>
            </form>

            <div class="kc-links">
                <a href="${url.loginUrl}">&larr; ${msg("backToLogin")}</a>
            </div>
        </div>
    </div>
</body>
</html>
