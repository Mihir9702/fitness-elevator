<template>
  <h1>{{ this.userProfile.firstName }} {{ this.userProfile.lastName }}</h1>
  <img src="" alt="Profile-Picture" />
  <!--TODO-->
  <p>Your goals are: {{ this.userProfile.goal }}</p>
  <router-link
    v-bind:to="{ name: 'workouts' }"
    style="margin-right: 5px"
    @click="showWorkouts"
    >Show Workouts</router-link
  >

  <router-link v-bind:to="{ name: 'newWorkout' }"
    >Start New Workout</router-link
  >
  <button @click="checkInOrOut">
    {{ isCheckedIn ? "check out" : "check in" }}
  </button>

  <button v-if="isCheckedIn" @click="logWorkout">
    {{ isWorkoutStarted ? "End Workout" : "Start Workout" }}
  </button>
</template>

<script>
import { mapState } from "vuex";
import UserService from "../services/UserService";
import WorkoutService from "../services/WorkoutService";
import WorkoutDetail from "../components/WorkoutDetail.vue";
import { RouterLink } from "vue-router";

export default {
  components: {
    // WorkoutDetail,
    RouterLink,
  },
  data() {
    return {
      userProfile: {
        userId: 0,
        firstName: "",
        lastName: "",
        email: "",
        profilePicture: "",
        goal: "",
      },
      isCheckedIn: false,
      isWorkoutStarted: false,
    };
  },

  mounted() {
    UserService.getProfile().then((res) => (this.userProfile = res.data));
    UserService.getLastCheckin().then(
      (response) => (this.isCheckedIn = response.data)
    );
    WorkoutService.getCurrentWorkout().then(
      (response) => (this.isWorkoutStarted = response.data ? true : false)
    );
  },

  computed: {
    ...mapState(["user"]),
  },

  methods: {
    checkInOrOut() {
      if (this.isCheckedIn) {
        UserService.checkOut();
        this.isCheckedIn = false;
      } else {
        UserService.checkIn();
        this.isCheckedIn = true;
      }
    },

    logWorkout() {
      if (this.isWorkoutStarted) {
        WorkoutService.endWorkout();
        this.isWorkoutStarted = false;
      } else {
        WorkoutService.startWorkout();
        this.isWorkoutStarted = true;
      }
    },
  },
};
</script>

<style></style>
