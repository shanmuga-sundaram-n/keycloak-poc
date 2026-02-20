<#import "template.ftl" as layout>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${msg("loginTitle", (realm.displayName!"Keycloak POC"))}</title>
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
            <#if realm.registrationAllowed>
                <a href="${url.registrationUrl}" class="nav-btn nav-btn-primary">Register</a>
            </#if>
        </div>
    </nav>

    <div class="kc-main">
        <div class="kc-card">
            <h1 class="kc-card-title">${msg("loginAccountTitle")}</h1>
            <p class="kc-card-subtitle">Enter your credentials to access your account</p>

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
                    <input type="text" id="username" name="username" value="${(login.username!'')}"
                           class="<#if messagesPerField.existsError('username','username-hint')>has-error</#if>"
                           autofocus autocomplete="username">
                    <#if messagesPerField.existsError('username','username-hint')>
                        <div class="field-error">${kcSanitize(messagesPerField.getFirstError('username','username-hint'))?no_esc}</div>
                    </#if>
                </div>

                <div class="form-group">
                    <label for="password">${msg("password")}</label>
                    <input type="password" id="password" name="password"
                           class="<#if messagesPerField.existsError('password')>has-error</#if>"
                           autocomplete="current-password">
                    <#if messagesPerField.existsError('password')>
                        <div class="field-error">${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}</div>
                    </#if>
                </div>

                <div class="form-options">
                    <#if realm.rememberMe && !useSocial>
                        <div class="checkbox-group">
                            <input type="checkbox" id="rememberMe" name="rememberMe"
                                   <#if login.rememberMe??>checked</#if>>
                            <label for="rememberMe">${msg("rememberMe")}</label>
                        </div>
                    </#if>
                    <#if realm.resetPasswordAllowed>
                        <a href="${url.loginResetCredentialsUrl}" class="forgot-link">${msg("doForgotPassword")}</a>
                    </#if>
                </div>

                <input type="hidden" id="credentialId" name="credentialId"
                       value="<#if auth.selectedCredential?has_content>${auth.selectedCredential}</#if>">

                <button type="submit" class="btn btn-primary">${msg("doLogIn")}</button>
            </form>

            <#if realm.registrationAllowed>
                <div class="kc-links">
                    ${msg("noAccount")} <a href="${url.registrationUrl}">${msg("doRegister")}</a>
                </div>
            </#if>
        </div>
    </div>
</body>
</html>
