function generateRandomPassword(length) {
    var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+{}[]|:;<>,.?/~";
    var password = "";
    for (var i = 0; i < length; i++) {
        var randomIndex = Math.floor(Math.random() * chars.length);
        password += chars.charAt(randomIndex);
    }
    return password;
}

// 비밀번호 생성 예시: 12자리
var newPassword = generateRandomPassword(8);
console.log("새로운 비밀번호:", newPassword);