import {dbank} from "../../declarations/dbank"

window.addEventListener("load", () => {
  // check the balance of the account
  update();
});

document.querySelector("form").addEventListener("submit", async function(event) {
  event.preventDefault();

  console.log("submitting form");

  const button = event.target.querySelector("#submit-btn");
  const inText = document.getElementById("input-amount");
  const outText = document.getElementById("withdraw-amount");
  button.setAttribute("disabled", true);

  const inAmount = parseFloat(inText.value);
  const outAmount = parseFloat(outText.value);

  if (inAmount > 0) {
    await dbank.topUp(inAmount);
  } else if (outAmount > 0) {
    await dbank.withdraw(outAmount);
  }

  update();

  button.removeAttribute("disabled");
  inText.value = "";
  outText.value = "";
});

async function update() {
  const balance = await dbank.checkBalance();
  document.getElementById("value").innerText = balance.toFixed(4);
}