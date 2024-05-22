# GistApp

The App is listing the Gist and when you click on any item, it will open an detail for the clicked item.


https://github.com/mattramsi/GistApp/assets/13910834/71c3cecb-b1a0-4f0c-8cff-19fea607cc82



I used ViewCode using UIKit.
Arch selected was MVVM-C, where we opted to inject the coordinator on VM to easier our unit tests and make the view as dummy as possible.
In the view model, in the future, you can create other protocols to inject on it, for example, if you wanna add an analytics class it is just necessary to create an protocol with the methods that you can track and then inject your concrete class using the platform of your preference.

Third Libraries

Pod SDWebImage which has no SPM, this library is used for control cache images.
SPM Snapshot to record snapshot from views.

The snapshots were being recorded on iPhone 15 Pro Max
