import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart'
    show PayUHashConstantsKeys;
import 'package:crypto/crypto.dart';
import 'dart:convert';
class HashService {
  // static const merchantSalt = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDElVfY/7pxiz1nrsIdan6BjbeFNVziYIjID4uXIczzHrF1bzJ0hAGhQV4b18nhIaYXIzEmgK/VmmkyqAhTM5Dnf158CnfQusyTwEvQ+bAlcNWzWd/qbFkfvapY07HzZ28kv27pBdoLw7NqdllozOTyPqp2pR4nH6e5AYsf6ewKAylrAlxBSmPp9rSC24FxO0BIurVKzBDokxjf+NEwxfhnLSDATbjJkzJkgAHZRbyLpiVmYbWg8xMtcyqJC4xCUCT7MaQ/4qi+5FWt1K4dzpCiGtnBUfdR4iitAcmln0Q6QpV/XOj2imMnJZ2BjuSFJRUvMXp4Tqz0Fg8SW92oXJSBAgMBAAECggEASuDj1EkcOFGkMxES6Wd+BlT3uWqpFaVVlHavYgLC8TwYtjWDz3PUtxqSASMBx5osjJWgDB1qXH9zYJM2kJKMuFEAqVjHaJ8ue3z8o/3nhWtkSuuJ6d4ZWIjDERCZsLAOWr38PhA3jNGfTocD6XJaJpeOEKE2Sgq5tTOMTbypZupACldn3gmwyQWq5dt5H60V4/PF4pZfAyPBuDCQzcoumULPSex4Q6/sjYF6RoA49HMVFBb2aZsTKMmtfKabUmaOtxRLh+E+jOjsP3R39UFZkA+uNqNTcKFDwjuo7ZbpBdGdGFez7QtignNss/wdlrxPEE25mnv8B1HxxF5kei/EDQKBgQDxWG/RHCiO0e9IzWLgNiE8uWSfd5dIHjU/eY/tLQR7FO2ktO7Iko06J40H/40+c3T0oEyDqkIHdLWmPFnlyyzQKFOuapE5G1DY+rsuOUskQyIQrARPMgHFgYMNgNXA5LRPITV1NnMdI6Aaffi+/48LsQybfAWN7986ltzjVEPRzwKBgQDQhRuh8rEEWkh1u6laM7Sa2qn8CjEbWYVfxjCun2DXO/BUVs93aub/IAoaiLB9JOXe/0knK1twHwmQ/fwIBdcNWU1TRDMLq3+fB7KNyo3qjoXH9k6B0mbUKqZb+nSYCCyF/cnMkrLEXpaTJsYdSdco1if4E+hT2RdoQZ040U9YrwKBgQCFGnEQsqbrnXyKejt9zFyoUNbd2+bjL0XOrAxkkd9WwkQOAntuwuSAni95qccMGkD2aTHJq6ye0A8ej0pFIbilVJhSKRPOmvILuLxi0dZPOXcgGr6Frt6rPrI4UEWTDI8k1PvWmSEDgRJbif4V2HvbxtldJxkpHpHOjkVkWqTMoQKBgDorB5xTwUG/lbsSEJoTFmykVwryJOTGQkiHVwk/eJpSJCbC2LktXycIXwkr3F/srRtaB6QfmjBa2CZUU7xBNM6KfOGfgsXcn4tTcGHRgWlPPM6dTSU19m11QFckNOY8UX9HXsXsnmXdJRADnvyInrbLlvbDRuotAzSYKS2yZfoNAoGBAJ/Kygr7UQfVrV4v7o43xQDVwQOjcR2ioF8pdx753nIe63M7fvtiATXz6m/w5MScgVg9UoXz+rz//PPyLCl2nELxRIWpAxBk+YuqYQV2xaR9EJQDFXIbRwOLCstchLMWV8d+PC9Uhzk8DBRz5bi92t5opQJZgwYIng0k6Lo2xGoP"; // Add you Salt here.
  static const merchantSalt = "MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCm5kQ37mtOiNdcDpdPG9vIwbGpQh1H8JStcFddUHVhnloqyuEFr2zuYB6gVz9pc2pd622LNw32Y/KuRHVH5AgDyhgzTQD0gYJc8IijhVAZ14k4EMIvy9CxAaW8l5H/A3Adx8pQ9D0iGle05u5QWNEdlD7GX1JByFYwnzk4KobHEuwV4Z3mn4zgGymIhFnTzMnUcpucyjCe5x/WNyF1xN+FgFl5Gdxoxry6R2MGdNa+F8k+tsie9jDk84WL7d4AB5v2ugDk9k8Fg3T6vfuRIshtSg67R+lwbspH7pfrC5XuRR4EjOsDSuujhDnJJyY7igRwHolMXNVAQAcexJ2UVU5NAgMBAAECggEAI3eVkak55oOP+IElSGtsJlp7DbP+EvaeMclI14yslSUYljVs4k9oP7PvbjV8RUWAmhrYuZfmgLC2tq/XmIJt7Zg50lUP2eXXtTZsYwuGfSdfgqmVCqEuZR8rgEtZfC7X2YxGgzOT9jZQ4yGcDTkCn12MhY1mJpKTNlvvxe7Lm2wi9jknp4Lcy4xB9NQRGS7bkweel9OoCKPYk+xe0Ce9Bmu53EyxHxQ2f6jAZoaMzsMgOZkvP+kSjLUx5S8+lL9MtOoHXa49MF0dw8igvrSy4e2ygaSs85NfXW6u9Sf0f9CcPQ82JCDyOv0VihpivpUi1xtXQIyrTJKLNR2bt1KzoQKBgQDcMSI1SBhxmP9lqGWUoj/mvLTuK9zsJSnabuzn/P0cAoegSMWrpOzLbWgt53ZNWilV8VkqeWtqcccgGM9MpKpCXDSYCP7uzHAgdpHYthYs5ZxhudN2Il8knq79uFHs21gtkpQeNZSxkGjeCCWKywxwYGOLAwbDVUemr/6osTV7OQKBgQDCCoBTTYK+lyQLw6DbogJxDjvt0tKLEtwl64vVSFpokzm3JeDD0l3bPqiKJin8DH3YXn1iRrJOM6bFBt4pwjF7t0Ghs0uQ2XengslcwF6UF6HUgFubIhYjC5t3WYMOHyD+rbjYzOt4vRNMLmoqEAIHMvbt0ZA7Zo1mabjDADuntQKBgH491UUDDrCibVsVTxgGZeieLIWYtFLXg8Vub3kaPOuAL84fquUb638+PMqEt/jlRmm1s898Sa9/iBDI6KEij1L4llbMYYz7vRV/pWLAErqu8he9eJV0Y2QVbnKc6KuJnmaScUVYpuWey+DwfsWyYHFVcfzTQV9gV3Ij2TdSUj1RAoGAZ9NspKY1zjtbGzxbBwpiGhJOuMt0wtudlmC52q6zSX91g20uHjmi5NxbHEidcHNSpwKwPnSrlbKHiqdJGrkA9zywTpB8X44tOyF9EzcPpFgczHK+EX0ksS3Vyv/HYzf+1Kcp4D+Nw3YQLFQtlEIqg6WegNQAQ/h0spbhON4YDX0CgYBgH/Yhy+HkKJRTtFZOJn3yjy5qwXvL16n73lsC3TP0nC9AGRKh8TB0a8dHXZk7M20M9aE0eEVvob0fdXAgPdVkNYJ+K+MUf6leH4ezpKURb3G1QjoIlTWkt9+qq2BCW8nQxMRdydf8/L3/2yIc+ZoYYEg9wGY5H3oM5XQ4v0LFBg=="; // Add you Salt here.
  // static const merchantSecretKey = "UiVBn1"; // Add Merchant Secrete Key - Optional
  static const merchantSecretKey = "nxmgUi"; // Add Merchant Secrete Key - Optional
  static Map generateHash(Map response) {
    var hashName = response[PayUHashConstantsKeys.hashName];
    var hashStringWithoutSalt = response[PayUHashConstantsKeys.hashString];
    var hashType = response[PayUHashConstantsKeys.hashType];
    var postSalt = response[PayUHashConstantsKeys.postSalt];
    var hash = "";
    if (hashType == PayUHashConstantsKeys.hashVersionV2) {
      hash = getHmacSHA256Hash(hashStringWithoutSalt, merchantSalt);
    } else if (hashName == PayUHashConstantsKeys.mcpLookup) {
      hash = getHmacSHA1Hash(hashStringWithoutSalt, merchantSecretKey);
    } else {
      var hashDataWithSalt = hashStringWithoutSalt + merchantSalt;
      if (postSalt != null) {
        hashDataWithSalt = hashDataWithSalt + postSalt;
      }
      hash = getSHA512Hash(hashDataWithSalt);
    }
    var finalHash = {hashName: hash};
    return finalHash;
  }
  static String getSHA512Hash(String hashData) {
    var bytes = utf8.encode(hashData);
    var hash = sha512.convert(bytes);
    return hash.toString();
  }
  static String getHmacSHA256Hash(String hashData, String salt) {
    var key = utf8.encode(salt);
    var bytes = utf8.encode(hashData);
    final hmacSha256 = Hmac(sha256, key).convert(bytes).bytes;
    final hmacBase64 = base64Encode(hmacSha256);
    return hmacBase64;
  }
  static String getHmacSHA1Hash(String hashData, String salt) {
    var key = utf8.encode(salt);
    var bytes = utf8.encode(hashData);
    var hmacSha1 = Hmac(sha1, key); // HMAC-SHA1
    var hash = hmacSha1.convert(bytes);
    return hash.toString();
  }
}