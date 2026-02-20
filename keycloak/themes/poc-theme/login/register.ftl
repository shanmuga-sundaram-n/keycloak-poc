<#import "template.ftl" as layout>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${msg("registerTitle")}</title>
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
        </div>
    </nav>

    <div class="kc-main">
        <div class="kc-card kc-card-wide">
            <h1 class="kc-card-title">${msg("registerTitle")}</h1>
            <p class="kc-card-subtitle">Create your account to get started</p>

            <#if message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                <div class="alert alert-${message.type}">
                    ${kcSanitize(message.summary)?no_esc}
                </div>
            </#if>

            <form action="${url.registrationAction}" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label for="firstName">${msg("firstName")}</label>
                        <input type="text" id="firstName" name="firstName" value="${(register.formData.firstName!'')}"
                               class="<#if messagesPerField.existsError('firstName')>has-error</#if>"
                               autocomplete="given-name">
                        <#if messagesPerField.existsError('firstName')>
                            <div class="field-error">${kcSanitize(messagesPerField.getFirstError('firstName'))?no_esc}</div>
                        </#if>
                    </div>

                    <div class="form-group">
                        <label for="lastName">${msg("lastName")}</label>
                        <input type="text" id="lastName" name="lastName" value="${(register.formData.lastName!'')}"
                               class="<#if messagesPerField.existsError('lastName')>has-error</#if>"
                               autocomplete="family-name">
                        <#if messagesPerField.existsError('lastName')>
                            <div class="field-error">${kcSanitize(messagesPerField.getFirstError('lastName'))?no_esc}</div>
                        </#if>
                    </div>
                </div>

                <div class="form-group">
                    <label for="email">${msg("email")}</label>
                    <input type="email" id="email" name="email" value="${(register.formData.email!'')}"
                           class="<#if messagesPerField.existsError('email')>has-error</#if>"
                           autocomplete="email">
                    <#if messagesPerField.existsError('email')>
                        <div class="field-error">${kcSanitize(messagesPerField.getFirstError('email'))?no_esc}</div>
                    </#if>
                </div>

                <#if !realm.registrationEmailAsUsername>
                    <div class="form-group">
                        <label for="username">${msg("username")}</label>
                        <input type="text" id="username" name="username" value="${(register.formData.username!'')}"
                               class="<#if messagesPerField.existsError('username')>has-error</#if>"
                               autocomplete="username">
                        <#if messagesPerField.existsError('username')>
                            <div class="field-error">${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}</div>
                        </#if>
                    </div>
                </#if>

                <div class="form-group">
                    <label for="password">${msg("password")}</label>
                    <input type="password" id="password" name="password"
                           class="<#if messagesPerField.existsError('password')>has-error</#if>"
                           autocomplete="new-password">
                    <#if messagesPerField.existsError('password')>
                        <div class="field-error">${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}</div>
                    </#if>
                </div>

                <div class="form-group">
                    <label for="password-confirm">${msg("passwordConfirm")}</label>
                    <input type="password" id="password-confirm" name="password-confirm"
                           class="<#if messagesPerField.existsError('password-confirm')>has-error</#if>"
                           autocomplete="new-password">
                    <#if messagesPerField.existsError('password-confirm')>
                        <div class="field-error">${kcSanitize(messagesPerField.getFirstError('password-confirm'))?no_esc}</div>
                    </#if>
                </div>

                <button type="submit" class="btn btn-primary">${msg("doRegister")}</button>
            </form>

            <div class="kc-links">
                Already have an account? <a href="${url.loginUrl}">${msg("backToLogin")?lower_case}</a>
            </div>
        </div>
    </div>
</body>
</html>
