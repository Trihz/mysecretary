class DataClassTodayTasks {
  String startDate = "";
  String endDate = "";
  String taskName = "";
  String taskDefinition = "";

  // getter methods for the variables
  String get getStartDate {
    return startDate;
  }

  String get getEndDate {
    return endDate;
  }

  String get getTaskName {
    return taskName;
  }

  String get getTaskDefinition {
    return taskDefinition;
  }

  // conctructor for the class
  DataClassTodayTasks(
      this.startDate, this.endDate, this.taskName, this.taskDefinition);
}
