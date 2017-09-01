function Student(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.courses = [];
}

Student.prototype.name = function() {
  return `${this.firstName} ${this.lastName}`;
};

Student.prototype.enroll = function(course) {
  if (!this.courses.includes(course) && !this.hasConflict(course)) {
    this.courses.push(course);
  }
};

Student.prototype.courseLoad = function() {
  const load = {};
  this.courses.forEach(course => {
    load[course.department] = load[course.department]
      ? load[course.department] + course.credits
      : course.credits;
  });

  return load;
};

Student.prototype.hasConflict = function(newCourse) {
  let conflict = false;
  this.courses.forEach(course => {
    if (course.conflictsWith(newCourse)) {
      conflict = true;
    }
  });

  return conflict;
};

function Course(courseName, department, credits, days, timeBlock) {
  this.courseName = courseName;
  this.department = department;
  this.credits = credits;
  this.students = [];
  this.days = days;
  this.timeBlock = timeBlock;
}

Course.prototype.addStudents = function(student) {
  if (!this.students.includes(student)) this.students.push(student);
  student.enroll(this);
};

Course.prototype.conflictsWith = function(course) {
  let conflict = false;

  this.days.forEach(currentDay => {
    course.days.forEach(newDay => {
      if (currentDay === newDay && this.timeBlock === course.timeBlock) {
        conflict = true;
      }
    });
  });

  return conflict;
};

let student1 = new Student("Nigel", "Leffler");
let course1 = new Course("101", "CS", 3, ["mon", "wed", "fri"], 1);
let course2 = new Course("201", "CS", 3, ["wed"], 1);
let course3 = new Course("301", "ENG", 3, ["tue"], 1);
let course4 = new Course("401", "BIO", 3, ["mon", "wed", "fri"], 2);
console.log(student1.name());
student1.enroll(course1);
student1.enroll(course3);
student1.enroll(course2);
console.log(student1.courseLoad());
console.log("should be true = " + course1.conflictsWith(course2));
console.log("should be false = " + course1.conflictsWith(course3));
console.log("should be false = " + course1.conflictsWith(course4));
