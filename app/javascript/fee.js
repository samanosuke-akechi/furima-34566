// 販売手数料・利益の計算結果表示
function calc (){
  const price = document.getElementById("item-price")
  price.addEventListener('keyup', () => {
    const fee = Math.floor(price.value * 0.1);
    const feeForm  = document.getElementById("add-tax-price");
    feeForm.innerHTML = `${fee}`;
    const profit = Math.floor(price.value) - fee;
    console.log(profit);
    const profitForm = document.getElementById("profit");
    profitForm.innerHTML = `${profit}`;
  })
}

window.addEventListener('load', calc);