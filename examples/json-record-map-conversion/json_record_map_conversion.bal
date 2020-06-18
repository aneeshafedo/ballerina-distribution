import ballerina/io;

// This is a Ballerina record definition.
type Person record {
    string fname;
    string lname;
    int age;
};

type Movie record {
    string title;
    string year;
    string released;
    Person writer;
};

type j1 json;

type map1 map<anydata>;

public function main() {
    Movie theRevenant = {
        title: "The Revenant",
        year: "2015",
        released: "08 Jan 2016",
        writer: {
            fname: "Michael",
            lname: "Punke",
            age: 30
        }
    };
    // This example shows how you can convert a record to a JSON object.
    // This conversion could return an error because it may not be possible
    // to convert some data types that are defined in the record to JSON.
    json|error j = theRevenant.cloneWithType(j1);
    if (j is json) {
        io:println(j.toJsonString());
        io:println(j.writer.lname);
    }

    // Similarly, you can convert a record to a map.
    map<anydata>|error movieMap = theRevenant.cloneWithType(map1);
    if (movieMap is map<anydata>) {
        Person|error writer = movieMap["writer"].cloneWithType(Person);
        if (writer is Person) {
            io:println(writer.age);
        }
    }

    // This example shows how you can convert a JSON object to a record.
    // This conversion could return an error because the field names and 
    // types are unknown until they are evaluated at runtime.
    json inceptionJ = {
        title: "Inception",
        year: "2010",
        released: "16 Jul 2010",
        writer: {
            fname: "Christopher",
            lname: "Nolan",
            age: 30
        }
    };
    Movie|error inception = inceptionJ.cloneWithType(Movie);
    if (inception is Movie) {
        io:println(inception);
    }
}
