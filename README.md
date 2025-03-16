### Summary: Include screen shots or a video of your app highlighting its features
![Screenshot 2025-03-16 at 1 06 42 AM](https://github.com/user-attachments/assets/9df55c9f-80cd-4e85-99d6-016c1a0985cf)


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
For this project, I focused primarily on two key requirements: "No External Dependencies" and "Efficient Network Usage" 
(requirements #2 and #3 from the project directions). One of the main challenges was figuring out how to persist images 
to disk and reload them efficiently without redownloading them from the network. Initially, I had planned to use an external 
framework like Kingfisher, which I’ve successfully used in production apps before. However, I enjoyed the challenge of 
implementing this functionality from scratch, and I now have reusable code for future projects that require custom disk 
persistence and caching. Given that efficient downloading and caching are fundamental to many apps, this was a valuable learning experience.

Another key focus was ensuring a smooth and responsive UI. To achieve this, I leveraged Swift’s async/await pattern along 
with AsyncImage for handling asynchronous operations. This approach helped maintain UI stability, preventing unnecessary 
blocking or freezing. While I didn’t prioritize extensive UI design, my main goal was to architect the app properly.

As an additional feature, I implemented a search bar to allow users to find recipes based on their input. I also briefly 
explored displaying the first frame of the YouTube video in the RecipeDetailView, but I ultimately decided it was a "nice to have" 
rather than a priority.

Overall, this project was a great learning experience, and I’m proud of what I accomplished—even if the final result was 
primarily for my own growth and knowledge.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent a total of four to five days on this project, stepping away at times to gain a fresh perspective and reassess my 
approach to certain challenges. A significant portion of my time—around 75%—was dedicated to figuring out how to persist 
and load images from disk, which was a key requirement of the project. To better understand this process, I even built a
separate prototype to test different approaches. The actual view construction was relatively quick, while writing tests 
accounted for the remainder of my time.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
As a design choice, I avoided using ViewModels to reduce complexity and keep the app lightweight. Instead, all business 
logic and reactive state management reside within Managers, which are injected at the start of the app. The only exceptions
are @State properties within individual views. I've used this pattern before, as it allows for easy dependency injection 
throughout the app and enables Managers to be injected into each other when needed, as seen with RecipeManager.

I also intentionally set the minimum deployment target to iOS 16 to align with Fetch's supported versions, as noted in the 
requirements. This decision meant I couldn't use @Observable and instead relied on @Published and ObservableObject for 
state management. If the app were built exclusively for iOS 17 and above, transitioning to @Observable would likely be the 
most significant change.

### Weakest Part of the Project: What do you think is the weakest part of your project?
I would say the weakest part of this app is the test coverage—I could likely improve it in certain areas. Admittedly,
the past few teams I’ve worked on were focused on racing to launch MVPs, and testing was often deprioritized (not by my choice). 
That said, once I establish a solid testing pattern, I have no problem maintaining thorough test coverage for every 
new feature I develop.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
I genuinely enjoyed this exercise and will definitely reference it in the future. Most take-home tests don’t require
avoiding external frameworks like this one did, and I think that challenge ultimately made me a better developer. 
I hope you’ll consider my candidacy, and I’d love for you to check out my LinkedIn media to see some of the cool 
things I built in my last project at Heirloom. Thanks for your time!

LinkedIn profile
https://www.linkedin.com/in/justin-kempton/

Movies of different flows I built at Heirloom
https://drive.google.com/file/d/1Z9jty8U3jhQDQWQug0ogm7U1NRLgGIWx/view
https://drive.google.com/file/d/1hfBhe05fEVvkiF_Zf_ZcLXb5GVx_-CTU/view
https://drive.google.com/file/d/183MFwBrWQd6NQrIQs3fJ42pfvw4aVgm4/view
