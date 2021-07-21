$ie = New-Object -ComObject 'internetExplorer.Application' -ErrorAction Ignore -ErrorVariable global:Fehler
$ie.Visible = $false
$ie.Navigate("https://www.ebay.de/sch/i.html?_from=R40&_nkw=3060&_sacat=0&_sop=15&LH_BIN=1&rt=nc&Speichergr%25C3%25B6%25C3%259Fe=12%2520GB&_dcat=27386") #Product Link sort by price low to high 
While($ie.Busy -eq $true){Start-Sleep -s 3}
$loc = 0
$products = $ie.Document.getElementsByClassName("s-item__link")
$price_tags = $ie.Document.getElementsByClassName("s-item__price")
foreach($price_tag in $price_tags){
if($price_tag.innerText[7] -eq ","){
[int]$intNum = [convert]::ToInt32($price_tag.innerText[4]+$price_tag.innerText[5]+$price_tag.innerText[6], 10) #convert Pricetag Text lower 1000€ to numeric Pricetag
}
if($price_tag.innerText[8] -eq ","){
[int]$intNum = [convert]::ToInt32($price_tag.innerText[4]+$price_tag.innerText[5]+$price_tag.innerText[6]+$price_tag.innerText[7], 10) #convert Pricetag text higher 999€ to numeric Pricetag
}
if($intNum -lt "700"){ #Target Price

write-host $intNum, $products[($loc + 1)].href
}
$loc ++
}
