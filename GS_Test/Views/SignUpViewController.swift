//
//  SignUpViewController.swift
//  GS_Test
//
//  Created by roshan on 14/06/21.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    var dobPicker: UIDatePicker!
    let signupViewmodel = SignUpViewModel()
   
    //MARK:- ViewControler life cycle events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDOBPicker()
        createGenderPicker()
        configureSignupButton()
        
        userImageView.addTapGesture(target: self, action: #selector(didTapImagePicker))
        bindControls()
        errorLabel.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        view.bindToKeyboard()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        view.RemoveBindingFromKeybaord()
    }
    
    //MARK:- Bindings
    /**
     Binds controls to viewmodel element
     */
    func bindControls(){
        signupViewmodel.isSignInSuccessfull.bindAndFire { [weak self](isSignedUp) in
            guard isSignedUp == true else{return}
            self?.NavigateToHomeScreen()
        }
    }
    
    //MARK:- Naviagtion
    fileprivate func NavigateToHomeScreen() {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard.init(name: Constants.storyboards.main, bundle: nil)
            let navigationController = storyboard.instantiateViewController(identifier: Constants.ViewControllerIdentifiers.naviagtionController)
            let currentWindow = UIApplication.shared.windows[0]
            currentWindow.rootViewController = navigationController
            
            UIView.transition(with: currentWindow,
                              duration: 1,
                              options: [.transitionFlipFromLeft],
                              animations: nil,
                              completion: nil)
        }
    }
    
    
    
   
    @objc func didTapImagePicker(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
    }
    //MARK:- Configure Controls
    fileprivate func configureSignupButton() {
        signUpButton.borderWidth = 2
        signUpButton.borderColor = UIColor (named: Constants.Colors.secondryColor)!
        signUpButton.backgroundColor = UIColor(named:Constants.Colors.secondryColor)!
        signUpButton.cornerRadius = 10
    }
    
    
    func createDOBPicker(){
        dobPicker = UIDatePicker()
        dobPicker.datePickerMode = .date
        dobPicker.maximumDate = signupViewmodel.dobMaxLimit
        dobPicker.minimumDate = signupViewmodel.dobMinLimit
        
        dobPicker.preferredDatePickerStyle = .wheels
        dobPicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        
        let doneButton = UIBarButtonItem.init(title: Constants.done, style: .done, target: self, action: #selector(self.datePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        dobTextField.inputView = dobPicker
        dobTextField.inputAccessoryView = toolBar
    }
    
    func createGenderPicker(){
        let genderPicker = UIPickerView()
        genderPicker.dataSource = self
        genderPicker.delegate = self
        
        let doneButton = UIBarButtonItem.init(title: Constants.done, style: .done, target: self, action: #selector(genderPickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        genderTextField.inputView = genderPicker
        genderTextField.inputAccessoryView = toolBar
    }
    
    //MARK:- Handle Control response
    @objc func dateChanged(){
    let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMM dd yyyy"
        dobTextField.text = "\(dateFormater.string(from: dobPicker.date))"
    }
    
    @objc func datePickerDone(){
        dobTextField.resignFirstResponder()
    }
    
    @objc func genderPickerDone(){
        genderTextField.resignFirstResponder()
    }
    
    /// Trigger signup for the user
    @IBAction func signUpUser(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty, let dob = dobTextField.text,!dob.isEmpty, let gender = genderTextField.text,!gender.isEmpty, let userImage = userImageView.image else{
            errorLabel.isHidden = false
            errorLabel.text = "All fields are mendatory. Please provide all deatils"
            return
        }
        signupViewmodel.triggerSignUp(forUser: name, dob: dob, gender: gender, image: userImage)
    }
}

//MARK:- Tableview Delegates & DataSource
extension SignUpViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return signupViewmodel.Genders.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return signupViewmodel.Genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = signupViewmodel.Genders[row]
    }
}

//MARK:- Textfield Delegate
extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case nameTextField:
            dobTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.text = ""
        errorLabel.isHidden = true
    }
}

//MARK:- Image Picker delegate
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        userImageView.image = image
           picker.dismiss(animated: true, completion: nil)

    }
    
}
