# Lubuntu > Ubuntu Lobster  
1) Only openbox installed  
  removed all default tools  
  
2) Default browser changed to waterfox with theses presets of security:  
   about:config  
    media.rdd-process.enabled > false  
    security.ssl.require_safe_negotiation > true  
    network.security.esni.enabled > true  
    browser.urlbar.speculativeConnect.enabled > false  
    dom.event.clipboardevents.enabled > false  
    network.IDN_show_punycode > true  
    network.cookie.cookieBehavior > 2  
    privacy.firstparty.isolate > true  
