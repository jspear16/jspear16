// Class for the Calcalator
class Calcalator {
// Attributes
    public prevOperand:Element;
    public currOperand:Element;
    public prevNum:number;
    public currNum:number;
    public prevOperator:string;
    public eqPushed:boolean;
    public dotPresent:boolean;

// Methods
    // === constructor =========================================================
    constructor(prevOp:Element, currOp:Element) {
        this.prevOperand = prevOp;
        this.currOperand = currOp;
        this.prevOperator = '';
        this.prevNum = 0;
        this.currNum = 0;
        this.eqPushed = false;
        this.dotPresent = false;
    }   /*  end constructor() */

    // === operate =========================================================
    operate(op:string)
    {
        let calculation: number = 0;
        this.prevNum = Number(this.prevOperand.textContent!.substring(0,this.prevOperand.textContent!.length-1).replace(/,/g, ''));
        this.currNum = Number(this.currOperand.textContent!.replace(/,/g, ''));

        switch(op)
        {
            case('+'):
            {
                if(this.prevOperand.textContent !== '')
                {
                    calculation = this.prevNum + this.currNum;
                }   /*  end if block    */
                else
                {
                    calculation = this.currNum;
                }   /*  end else block    */

                this.prevOperand.textContent = calculation.toLocaleString('en') + '+';
                break;
            }   /*  end case block    */
            case('-'):
            {
                if(this.prevOperand.textContent !== '')
                {
                    calculation = this.prevNum - this.currNum;
                }   /*  end if block    */
                else
                {
                    calculation = this.currNum;
                }   /*  end else block    */

                this.prevOperand.textContent = calculation.toLocaleString('en') + '-';
                break;
            }   /*  end case block    */
            case('*'):
            {
                if(this.prevOperand.textContent !== '')
                {
                    calculation = this.prevNum * this.currNum;
                }   /*  end if block    */
                else
                {
                    calculation = this.currNum;
                }   /*  end else block    */

                this.prevOperand.textContent = calculation.toLocaleString('en') + '*';
                break;
            }   /*  end case block    */
            case('÷'):
            {
                if(this.prevOperand.textContent !== '')
                {
                    calculation = this.prevNum / this.currNum;
                }   /*  end if block    */
                else
                {
                    calculation = this.currNum;
                }   /*  end else block    */

                this.prevOperand.textContent = calculation.toLocaleString('en') + '÷';
                break;
            }   /*  end case block    */
            default:
            {
                console.error("An unknown operator was received. Operator is", op);
                break;
            }   /*  end default block    */
        }   /*  end if block    */
        this.currOperand.textContent = '';
        this.dotPresent = false;
        this.prevOperator = op;
    }   /*  end operate()    */

    // === equal =========================================================
    equal() {
        let calculation:number = 0;
        let operator:string;
        let currText:string;

        this.prevNum = Number(this.prevOperand.textContent!.substring(0,this.prevOperand.textContent!.length-1).replace(/,/g, ''));
        this.currNum = Number(this.currOperand.textContent!.replace(/,/g, ''));

        if(this.currOperand.textContent !== '')
        {
            operator = this.prevOperand.textContent![this.prevOperand.textContent!.length-1];
            switch(operator)
            {
                case('+'):
                {
                    calculation =   this.prevNum + this.currNum;
                    break;
                }   /*  end case block    */
                case('-'):
                {
                    calculation =   this.prevNum - this.currNum;
                    break;
                }   /*  end case block    */
                case('*'):
                {
                    calculation =   this.prevNum * this.currNum;
                    break;
                }   /*  end case block    */
                case('÷'):
                {
                    calculation = this.prevNum / this.currNum;
                    break;
                }   /*  end case block    */
            }   /*  end switch block    */
        }   /*  end if block    */
        else
        {
            calculation = this.currNum;
        }   /*  end else block    */
        currText = calculation.toLocaleString('en');

        this.prevOperand.textContent = '';
        this.currOperand.textContent = currText;
        this.eqPushed = true;
        this.dotPresent = false;
        }   /*  end equal()    */

    // === clear =========================================================
    clear() {
        this.currOperand.textContent = '';
        this.prevOperand.textContent = '';
        this.prevOperator = '';
        this.eqPushed = false;
        this.dotPresent = false;
    }   /*  end clear()    */

    // === delete =========================================================
    delete() {
        this.currOperand.textContent = this.currOperand.textContent?.substring(0, this.currOperand.textContent.length-1)!;
    }   /*  end delete()    */

    // === dot =========================================================
    dot() {

        if(this.eqPushed === true)
        {
            this.eqPushed = false;
            this.currOperand.textContent = '0.';
            return;
        }   /*  end if block    */


        if(this.dotPresent === false)
        {
            // Search returns -1 if search failes. So check for successful search
            if(this.currOperand.textContent?.search('.') === -1)
            {
                // Getting here indicates a . is already present
                if(this.currOperand.textContent === '')
                {
                    this.currOperand.append('0.');
                }   /*  end if block    */
                else
                {
                    console.log("In dot: ", this.currOperand.textContent);
                }   /*  end else block    */
            }   /*  end if block    */
            else
            {
                // This means a . is not already present
                if(this.currOperand.textContent === '')
                {
                    this.currOperand.append('0.');
                }   /*  end if block    */
                else
                {
                    console.log("hereerere")
                    this.currOperand.append('.');
                }   /*  end else block    */
            }   /*  end else block    */
            this.dotPresent = true;
        }   /*  end if block    */
    }   /*  end dot()   */


    // === display =========================================================
    display(newNumText:string) {
        // Checking the eq
        if(this.eqPushed === true)
        {
            this.eqPushed = false;
            this.currOperand.textContent = newNumText;
        }   /*  end if block    */
        else
        {
            /*  Split the string based off of the '.'. If there isn't one in 
                the text, then it is just an integer and the split().length 
                will be 1, otherwise there is a '.' in the array    */
            let subText = this.currOperand.textContent?.split('.');

            if(subText?.length !== 1)
            {
                let wholePart = subText![0].replace(/,/g, '');
                let fracPart = subText![1].replace(/,/g, '');
                this.currNum = Number(wholePart);
                
                this.currOperand.textContent = this.currNum.toLocaleString('en') + '.' + fracPart + newNumText;
            }
            else
            {
                // Create the new currNum based off of the currOperand text, commas removed
                this.currNum = Number(this.currOperand.textContent?.replace(/,/g, ''));
                this.currNum = Number(this.currNum.toString() + newNumText);

                this.currOperand.textContent = this.currNum.toLocaleString('en');
                Number(this.currOperand.textContent);
            }
                
        }   /*  end else block  */
    }   /* end display()   */
}   /*  end class Calcalator    */

// DOM elements
const prevOperandText:Element = document.querySelector('[data-prev-operand]')!;
const currOperandText:Element = document.querySelector('[data-curr-operand]')!;
const nums = document.querySelectorAll('[data-number]');
const dot = document.querySelector('[data-dot]');
const ops = document.querySelectorAll('[data-operator]');
const equal = document.querySelector('[data-equal]');
const clr = document.querySelector('[data-clear]');
const del = document.querySelector('[data-delete]');

// Instance of calcalator
const calc = new Calcalator(prevOperandText, currOperandText);

// Add Listeners
nums.forEach((num) => {
    num.addEventListener('click', () => calc.display(num.textContent!));
});

ops.forEach((op) =>{
    op.addEventListener('click', () => calc.operate(op.textContent!));
});

dot?.addEventListener('click', () => calc.dot());
equal?.addEventListener('click', () => calc.equal());
clr?.addEventListener('click', () => calc.clear());
del?.addEventListener('click', () => calc.delete());

// Getting the current year and putting it with the Copyright
const currDate = new Date();
const dateSelector = document.querySelector("#dateTime")!;
dateSelector.append(currDate.getFullYear().toString());