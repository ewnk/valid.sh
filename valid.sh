#!/bin/bash
#Apple Valid 
#Coded by PandaTech
#IBT - IndoXploit
header_apple() {
figlet -f small "Apple Valid"
echo "		Powered By PamungkasSmith"
}
ngecek() {
    local a=$(curl -s 'https://iforgot.apple.com/password/verify/appleid' \
    -H 'Cookie: xp_ci=3z2Tn114z3eIz5IHzBLczQEiN8OOp; ndcd=wc1.1.w-046483.1.2.JQFiMMqmEFFYHER9ccamlA%252C%252C.nVFL61eqa7IzrcqPGYD8845ZX9HAzJXg884BncGEs1WaL38tbniPzUe8LMvA5eJQDT5m0ekhQhge0Yp2z2G0tpFqbZ6X6FZObTwfkGxns1oCKUfjkLLORLbS9b-4Img6CF8qVZH6SpmLWi8CljbIEonHXdH4Vk-YI1DqOiRJ3ABAg27PuLXaLTWIQ8zROiW_; dslang=US-EN; site=USA; geo=ID; ccl=Vo654CTpoZ5KzVYNUmK6wA==; adsv=8fgLEJM3ZJ; idclient=web; ifssp=B34A12EFA8FD59ADD7EE2CD75FA4D0EBF99306D95624045ACC2EFD00B7A08A72FAEA088898065E76B60731A19B09C3086F353FDAE32B3EF0D027FE37F87954250D26CA8EE1716EBAA45955B0E9E4E5AB999BE0EB2699EA4F93BAE3C3BB828CC02197015E5E30BBA232DADC2C817177B1F8E98BE0B29CBEF7' -H 'Origin: https://iforgot.apple.com' -H 'Accept-Encoding: gzip, deflate, br' -H 'X-Apple-I-FD-Client-Info: {"U":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36","L":"en-US","Z":"GMT+07:00","V":"1.1","F":"cGa44j1e3NlY5BSo9z4ofjb75PaK4Vpjt.gEngMQEjZr_WhXTA2s.XTVV26y8GGEDd5ihORoVyFGh8cmvSuCKzIlnY6xljQlpRD_AQnHPMfbquypZHgfLMC7AeLd7FmrpwoNN5uQ4s5uQ.gEx4xUC541jlS7spjt.gEngMQEjZr_WhXTA2s.XTVV26y8GGEDd5ihORoVyFGh8cmvSuCKzIlnY6xljQlpRD_AQnHPMfbquypZHgfLMC7Awvw0BpUMnGWqbyATblVnmccbguaDeyjaY2ftckuyPBDjaY1HGOg3ZLQ0I0BQfp_Kp2q2TLs2dI_AIQjvEodUW2vqCReF.j92eBSp8jV1dY.4I0K691RcWprTKyKIy6fwHCSFQ_H.4tJxQgFY5BNlrJNNlY5QB4bVNjMk.2HF"}' -H 'Accept-Language: en-US,en;q=0.9' -H 'sstt: V73Aq7E2TrLH7p1atsvGfBEjCqAbaxVDcTI%2B%2F%2BP52FtXkW23eiKHGSa%2BRwKAjC%2Fv3Zo8cKiLR6crfcWmYWN0qfIt%2Bg5DgfyRP1vQlw9RthqJC1Eks2UElwx6U9G7CjygMVw7mOPAs3J6KuSx%2FoWKyzOSBhhoBSxPYLphZVGKlE58pc3jXnbwEPZlkG07MjEbpMarZ5n635x6tTj%2FGYuT3QI3nWOjspWHUzCXDQwU1ZP%2Blcm9trep2DWbkf2JZsyZ8mtMGFvbfbXoAgWz%2FLE4j%2FpGEa2p%2FbRsQlsr9RbFzkrdhKKYXiKLiGScBUg7JXdN%2FJeqSOsjmDT3hxcGYl4%2BrwAMuB7OZw2rUy%2BKKLy7atr413ns%2F55QeZR7QrRmh7MtpYE18c3N0SpJzEh0' \
    -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36' \
    -H 'Content-Type: application/json' \
    -H 'Accept: application/json, text/javascript, */*; q=0.01' \
    -H 'Referer: https://iforgot.apple.com/password/verify/appleid' \
    -H 'X-Requested-With: XMLHttpRequest' \
    -H 'Connection: keep-alive' \
    --data-binary "{\"id\":\"$1\"}" --compressed -D - -L)
    if [[ $a =~ "session/timeout" ]]; then
        echo "LIVE | $1 "
        echo $1 >> live.txt
    else
        if [[ $a =~ "false" ]]; then
            echo "DEAD | $1 "
            echo $1 >> die.txt
        else
            echo "UNKNOWN | $1 "
            echo $1 >> unknown.txt
        fi
    fi
}

red="\e[31m"
green="\e[32m"

header_apple
list=$1
if [[ -z $list ]]; then
    read -p "[+] Enter your mailist : " list
fi
##set ratio
request=3
sleep=0.5

itungList=`wc -l $list`
printf "[!] Your mailist : ${itungList}\n"
printf "[!] Set Ratio : ${request}/${sleep}sec.\n"
printf "[>] Begin to check..\n\n"
itung=0
for email in $(cat $list); do
    footer="Checked"
    fold=`expr $itung % $request`
    if [[ $fold == 0 && $itung > 0 ]]; then
      printf "[-] Sleep $sleep sec.\n"
      sleep $sleep
    fi
    ngecek $email "$footer"
    grep -v -- "$email" $list > "temp" && mv "temp" $list
    itung=$[$itung+1]
done
printf "\nFinish check!\n"
