## Kubernetes YAML Basics
- YAML is not a Markup Language
- YAML is used to store information about different things
- We can use YAML  to define key, Value pairs like variables, lists and objects
- YAML is very similar to JSON (Javascript Object Notation)
- YAML primarily focuses on readability and user friendliness
- YAML is designed to be clean and easy to read
- We can define YAML files with two different extensions
    - abc.yml
    - abc.yaml


# YAML Comments
Comments & Key Value Pairs
- Space after colon is mandatory to differentiate key and value

```yml

# Defining simple key value pairs
name: kalyan
age: 23
city: Hyderabad

```
# Dictionary / Map
- Set of properties grouped together after an item
- Equal amount of blank space required for all the items under a dictionary

```yml
person: # Dictionary / Map
  name: kalyan
  age: 23
  city: Hyderabad
```

#  Array / Lists
- Dash indicates an element of an array

```yml
person: # Dictionary
  name: kalyan
  age: 23
  city: Hyderabad
  hobbies: # Array / Lists
    - cycling
    - cookines
  hobbies: [cycling, cooking]   # List with a differnt notation  
```

# Multiple Lists

- Dash indicates an element of an array
```yml
person: # Dictionary
  name: kalyan
  age: 23
  city: Hyderabad
  hobbies: # List  
    - cycling
    - cooking
  hobbies: [cycling, cooking]   # List with a differnt notation  
  friends: # 
    - name: friend1
      age: 22
    - name: friend2
      age: 25            

```
# Sample Pod Tempalte for Reference


```yml
apiVersion: v1 # String
kind: Pod  # String
metadata: # Dictionary
  name: myapp-pod
  labels: # Dictionary 
    app: myapp         
spec:
  containers: # List
    - name: myapp
      image: stacksimplify/kubenginx:1.0.0
      ports:
        - containerPort: 80
          protocol: "TCP"
        - containerPort: 81
          protocol: "TCP"
```

## YAML Document Separator
- `---` This symbol denotes doc seperator # YAML Document Separator
