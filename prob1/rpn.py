''' Simple RPN calculator with test on Bill.

The rpn function in this module is extra careful about its input and
the state of its stack. This is in general a good coding practice, as
otherwise an obtuse error will be thrown by some deeper function. The Python
philosophy is to "fail hard and fast". As such, the functions from the
standard Python library should have your back should you forget to raise a
certain type of error.
'''

import operator as op

from prob1 import talkToBill

def rpn(sequence):
    ''' Evaluates a Reverse Polish Notation (RPN) sequence.

    Parameters
    ----------
    sequence : list of numbers and operators, or a string

    Returns
    -------
    int
        Returns the result of the computation.

    Raises
    ------
    ValueError
        When the input string contains an invalid character.

    ValueError
        When the input contains items that are not numbers or operators.

    ValueError
        When the stack is exhausted.

    ValueError
        There is more than one item left on the stack at the end.
    '''

    str_ops = { '+': op.add, '-': op.sub, '*': op.mul, '/': op.truediv }

    ## Turn string into the standard list of numbers and operators format.
    if isinstance(sequence, str):

        ## Turn into a list of "words"
        sequence = sequence.split()

        ## Try to convert things. If that fails, we have a string that makes
        ## no sense for the RPN calculator.
        try:
            for i, word in enumerate(sequence):
                if word in str_ops:
                    sequence[i] = str_ops[word]
                else:
                    ## See http://goo.gl/b2Umij for setting the actual
                    ## correct type (int or float). However, the
                    ## approximation that everything is a float is ok for an
                    ## RPN calculator.
                    sequence[i] = float(word)

        except ValueError:
            raise ValueError("Input string contained not RPN character")

    ## Do not accept invalid sequences.
    if any( not(isinstance(x, float) or isinstance(x, int) or
                (x in str_ops.values()))
            for x in sequence):
        raise ValueError("Input must contain only operators or numbers.")

    ## An RPN calculator works by pushing items to a stack if they are
    ## numbers or performing evaluations on that stack if the next item in
    ## the sequence is an operator.
    stack = []

    for item in sequence:

        ## We make the assumption that all numbers are floats or ints.
        ## There is a more generic way to perform this check. See
        ## https://docs.python.org/3.2/library/numbers.html
        if isinstance(item, float) or isinstance(item, int):
            stack.append(item)

        else: ## item must be operator by line 67 above.

            try:
                ## All operators are binary, so we need to operate on two
                ## elements of the stack.
                second, first = stack.pop(), stack.pop()
            except IndexError:
                raise ValueError("Empty Stack")

            ## Append the result of the calculation to the list.
            stack.append(item(first, second))

    if len(stack) > 1:
        raise ValueError("More than one item on the stack")

    return stack.pop()


## If I run this as a script (ex: 'python rpn.py') Otherwise I can import
## rpn.py and use the rpn function in other files.
if __name__ == '__main__':

    ## Make Bill calculate things for me.
    print("Calculating the following expression: '1 2 + 4 * 5 + 3 -'")
    print(talkToBill(lambda x: rpn("1 2 + 4 * 5 + 3 -")))
