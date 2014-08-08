import pickle

def talkToBill(f = lambda x: x):
    ''' Bill, the weird salesman

    Bill only responds to single statement inputs.

    Parameters
    ----------
    f : statement to ask.
        What do you want to ask Bill?

    Returns
    -------
    Depends!
    '''

    ## DO NOT EDIT BILL! He is such a sweet guy, mutilating him is cruel.
    if not (isinstance(f, type(lambda: None)) and f.__name__ == '<lambda>'):
        print("Bill does not respond to multi-line statements")
        return

    if f.__code__.co_argcount is not 1:
        print("Bill does not respond to more than one input")
        return

    return f(pickle.loads(b'\x80\x03}q\x00(X\x04\x00\x00\x00pearq\x01G?\xf8\x00\x00\x00\x00\x00\x00X\x07\x00\x00\x00cabbageq\x02G@\x04\x00\x00\x00\x00\x00\x00X\t\x00\x00\x00aubergineq\x03G@\x08\x00\x00\x00\x00\x00\x00X\x05\x00\x00\x00appleq\x04G?\xf4\x00\x00\x00\x00\x00\x00u.'))
