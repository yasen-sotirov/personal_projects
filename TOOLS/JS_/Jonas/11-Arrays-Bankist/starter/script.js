'use strict';

/////////////////////////////////////////////////
/////////////////////////////////////////////////
// BANKIST APP

// Data
const account1 = {
  owner: 'Jonas Schmedtmann',
  movements: [200, 450, -400, 3000, -650, -130, 70, 1300],
  interestRate: 1.2, // %
  pin: 1111,
};

const account2 = {
  owner: 'Jessica Davis',
  movements: [5000, 3400, -150, -790, -3210, -1000, 8500, -30],
  interestRate: 1.5,
  pin: 2222,
};

const account3 = {
  owner: 'Steven Thomas Williams',
  movements: [200, -200, 340, -300, -20, 50, 400, -460],
  interestRate: 0.7,
  pin: 3333,
};

const account4 = {
  owner: 'Sarah Smith',
  movements: [430, 1000, 700, 50, 90],
  interestRate: 1,
  pin: 4444,
};

const accounts = [account1, account2, account3, account4];


// Elements
const labelWelcome = document.querySelector('.welcome');
const labelDate = document.querySelector('.date');
const labelBalance = document.querySelector('.balance__value');
const labelSumIn = document.querySelector('.summary__value--in');
const labelSumOut = document.querySelector('.summary__value--out');
const labelSumInterest = document.querySelector('.summary__value--interest');
const labelTimer = document.querySelector('.timer');

const containerApp = document.querySelector('.app');
const containerMovements = document.querySelector('.movements');

const btnLogin = document.querySelector('.login__btn');
const btnTransfer = document.querySelector('.form__btn--transfer');
const btnLoan = document.querySelector('.form__btn--loan');
const btnClose = document.querySelector('.form__btn--close');
const btnSort = document.querySelector('.btn--sort');

const inputLoginUsername = document.querySelector('.login__input--user');
const inputLoginPin = document.querySelector('.login__input--pin');
const inputTransferTo = document.querySelector('.form__input--to');
const inputTransferAmount = document.querySelector('.form__input--amount');
const inputLoanAmount = document.querySelector('.form__input--loan-amount');
const inputCloseUsername = document.querySelector('.form__input--user');
const inputClosePin = document.querySelector('.form__input--pin');



// DISPLAY MOVEMENT
const displayMovements = function (movements) {
  // зачиства същ. html
  containerMovements.innerHTML = '';

  // итерира през всеки елемент
  movements.forEach(function (mov, i) {
    const type = mov > 0 ? 'deposit' : 'withdraw';
    const html = `
      <div class="movements__row">
        <div class="movements__type movements__type--${type}">
        ${i + 1} ${type}</div>
        <div class="movements__value">${mov} €</div>
      </div>
    `;

    // влага променения html в кода        в прав ред
    containerMovements.insertAdjacentHTML('afterbegin', html);
  });
};



// CALC BALANCE
const calcDisplayBalance = function (acc) {
  const balance = acc.movements.reduce((acc, curr) => acc + curr, 0);
  acc.balance = balance;
  labelBalance.textContent = `${balance}€`;
};



// CALC SUMMARY
const calcDisplaySummary = function (acc) {
  const incomes = acc.movements
    .filter(mov => mov > 0)
    .reduce((accu, curr) => accu + curr, 0);
  labelSumIn.textContent = `${incomes}€`;

  // CALC OUTGOING
  const out = acc.movements
    .filter(mov => mov < 0)
    .reduce((acc, curr) => acc + curr);
  labelSumOut.textContent = `${Math.abs(out)}€`;

  // CALC DEPOSIT INTEREST
  const interest = acc.movements
    .filter(mov => mov > 0)
    .map(deposit => (deposit * acc.interestRate) / 100)
    .filter(int => int >= 1)
    .reduce((accu, curr) => accu + curr);
  labelSumInterest.textContent = `${interest}€`;
};



// CREATE USERNAME
const createUsername = function (accs) {
  accs.forEach(function (acc) {
    // добавя username към обекта
    acc.username = acc.owner
      .toLowerCase()
      .split(' ')
      .map(name => name[0])
      .join('');
  });
};
createUsername(accounts);



const updateUI = function (acc) {
      // Display movements
      displayMovements(acc.movements);
      // Display balance
      calcDisplayBalance(acc);
      // Display summary
      calcDisplaySummary(acc);
};


// CONVERT EURO TO USD
// const euroToUsd = 1.1;
// const totalDepositUSD = movements
//   .filter(mov => mov > 0)
//   .map(mov => mov * euroToUsd)
//   .reduce((accu, curr) => accu + curr, 0);

// console.log(totalDepositUSD);


// Event handler
let currentAccount;


btnLogin.addEventListener('click', function (event) {
  // prevent default form to submitting
  event.preventDefault();

  currentAccount = accounts.find(
    acc => acc.username === inputLoginUsername.value
  );
  console.log(currentAccount);

  if (currentAccount?.pin === Number(inputLoginPin.value)) {
    // Display UI and message
    labelWelcome.textContent = `Welcome back ${
      currentAccount.owner.split(' ')[0]
    }`;
    containerApp.style.opacity = 100;

    // clear input field from pin and username
    inputLoginUsername.value = inputLoginPin.value = '';
    // маха мигащия курсор от полето
    inputLoginPin.blur();

    // Update UI
    updateUI(currentAccount);
  }
});


// TRANSFER MONEY TO ANOTHER ACCOUNT
btnTransfer.addEventListener('click', function (event) {
  // спира формата да презареди страницата
  event.preventDefault();
  const amount = Number(inputTransferAmount.value);
  const receiverAcc = accounts.find(
    acc => acc.username === inputTransferTo.value);

  inputTransferAmount = inputTransferTo = '';
    
  if(amount > 0 &&
    receiverAcc && 
    currentAccount.balance >= amount && 
    currentAccount.username !== receiverAcc.username
  ) {
    currentAccount.movements.push(-amount);
    receiverAcc.movements.push(amount);
    
    updateUI(currentAccount)
  } 
})