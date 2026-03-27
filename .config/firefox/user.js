// ============================================================
//  Cyberpunk Firefox — user.js
//  about:config overrides applied on every Firefox startup.
// ============================================================

// --- Enable userChrome.css / userContent.css ---
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// --- UI: Compact and minimal ---
user_pref("browser.uidensity", 1);                    // compact mode
user_pref("browser.theme.content-theme", 0);           // dark content
user_pref("browser.theme.toolbar-theme", 0);           // dark toolbar
user_pref("browser.tabs.inTitlebar", 0);               // needed for CSS tab hiding
user_pref("browser.compactmode.show", true);           // show compact option in customize

// --- New tab: blank ---
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.startup.homepage", "about:blank");
user_pref("browser.newtabpage.activity-stream.enabled", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);

// --- DRM / Media (Netflix, Spotify, etc.) ---
user_pref("media.eme.enabled", true);

// --- Privacy (matching qutebrowser config) ---
user_pref("webgl.disabled", true);                     // disable WebGL
user_pref("privacy.resistFingerprinting.autoDeclineNoUserInputCanvasPrompts", true);
user_pref("geo.enabled", false);                       // no geolocation
user_pref("media.peerconnection.ice.default_address_only", true); // WebRTC: default interface only
user_pref("privacy.webrtc.legacyGlobalIndicator", false);

// --- Disable annoyances ---
user_pref("browser.aboutConfig.showWarning", false);   // no about:config warning
user_pref("browser.shell.checkDefaultBrowser", false); // don't nag about default
user_pref("browser.tabs.warnOnClose", false);
user_pref("browser.tabs.warnOnCloseOtherTabs", false);
user_pref("extensions.pocket.enabled", false);         // disable Pocket
user_pref("browser.urlbar.suggest.pocket", false);
user_pref("browser.urlbar.suggest.topsites", false);
user_pref("browser.urlbar.trending.featureGate", false);
user_pref("browser.urlbar.showSearchSuggestionsFirst", false);

// --- Session restore (like qutebrowser's auto_save.session) ---
user_pref("browser.sessionstore.resume_from_crash", true);
user_pref("browser.startup.page", 3);                  // restore previous session

// --- Smooth scrolling ---
user_pref("general.smoothScroll", true);
