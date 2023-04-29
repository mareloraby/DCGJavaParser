from pyswip import Prolog

# Load the Prolog file
prolog = Prolog()
prolog.consult('DCGJava.pl')

# Loop over the queries in the txt file
with open('incorrectStatements.txt', 'r') as f:
    
    for i, line in enumerate(f):
    # Skip the first line
        if i == 0:
            continue

        # Remove the newline character from the query
        query = line.strip()
        print(query)
        
        # Evaluate the query in Prolog
        results = list(prolog.query(query))

        print(bool(results))
        # print(results[-1])