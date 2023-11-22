import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piiicks/configs/configs.dart';
import 'package:piiicks/core/router/app_router.dart';
import 'package:piiicks/presentation/widgets/custom_appbar.dart';
import 'package:piiicks/presentation/widgets/textfield_toptext.dart';

import '../../application/delivery_info_action_cubit/delivery_info_action_cubit.dart';
import '../../application/delivery_info_fetch_cubit/delivery_info_fetch_cubit.dart';
import '../../data/models/delivery/delivery_info_model.dart';
import '../../domain/entities/delivery/delivery_info.dart';
import '../widgets/custom_textfield.dart';

class AddAdressScreen extends StatefulWidget {
  final DeliveryInfo? deliveryInfo;

  const AddAdressScreen({
    super.key,
    this.deliveryInfo,
  });

  @override
  State<AddAdressScreen> createState() => _AddAdressScreenState();
}

class _AddAdressScreenState extends State<AddAdressScreen> {
  String? id;
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController addressLineOne = TextEditingController();
  final TextEditingController addressLineTwo = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController zipCode = TextEditingController();
  final TextEditingController contactNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.deliveryInfo != null) {
      id = widget.deliveryInfo!.id;
      firstName.text = widget.deliveryInfo!.firstName;
      lastName.text = widget.deliveryInfo!.lastName;
      addressLineOne.text = widget.deliveryInfo!.addressLineOne;
      addressLineTwo.text = widget.deliveryInfo!.addressLineTwo;
      city.text = widget.deliveryInfo!.city;
      zipCode.text = widget.deliveryInfo!.zipCode;
      contactNumber.text = widget.deliveryInfo!.contactNumber;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("ADD NEW ADDRESS"),
      body: BlocListener<DeliveryInfoActionCubit, DeliveryInfoActionState>(
        listener: (context, state) {
          if (state is DeliveryInfoActionLoading) {
          } else if (state is DeliveryInfoAddActionSuccess) {
            context
                .read<DeliveryInfoFetchCubit>()
                .addDeliveryInfo(state.deliveryInfo);
            Navigator.of(context).pop();
          } else if (state is DeliveryInfoEditActionSuccess) {
            context
                .read<DeliveryInfoFetchCubit>()
                .editDeliveryInfo(state.deliveryInfo);
            Navigator.of(context).pop();
          } else if (state is DeliveryInfoActionFail) {}
        },
        child: Padding(
          padding: Space.all(1.2, 0),
          child: Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFieldTopText("First Name*"),
                    buildTextFormField(firstName, 'First name', false),
                    TextFieldTopText("Last name*"),
                    buildTextFormField(lastName, 'Last name', false),
                    TextFieldTopText("Line One*"),
                    buildTextFormField(
                        addressLineOne, 'Address line one', false),
                    TextFieldTopText("Line Two*"),
                    buildTextFormField(
                        addressLineTwo, 'Address line two', false),
                    TextFieldTopText("City*"),
                    buildTextFormField(city, 'City', false),
                    TextFieldTopText("Zip Code*"),
                    buildTextFormField(zipCode, 'Zip code', false),
                    TextFieldTopText("Contact number*"),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            width: AppDimensions.normalize(30),
                            height: AppDimensions.normalize(20),
                            decoration: BoxDecoration(color: Colors.black),
                            child: Center(
                                child: Text(
                              "+20",
                              style: AppText.b1b?.copyWith(color: Colors.white),
                            )),
                          ),
                        ),
                        Flexible(
                            flex: 4,
                            child: buildTextFormField(
                                contactNumber, 'Contact number', false)),
                      ],
                    ),
                    Space.yf(2),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (widget.deliveryInfo == null) {
                              context
                                  .read<DeliveryInfoActionCubit>()
                                  .addDeliveryInfo(DeliveryInfoModel(
                                    id: '',
                                    firstName: firstName.text,
                                    lastName: lastName.text,
                                    addressLineOne: addressLineOne.text,
                                    addressLineTwo: addressLineTwo.text,
                                    city: city.text,
                                    zipCode: zipCode.text,
                                    contactNumber: contactNumber.text,
                                  ));
                              /* Navigator.of(context).pushNamedAndRemoveUntil(
                                AppRouter.mainscreen,
                                ModalRoute.withName(''),
                              );*/
                            } else {
                              context
                                  .read<DeliveryInfoActionCubit>()
                                  .editDeliveryInfo(DeliveryInfoModel(
                                    id: id!,
                                    firstName: firstName.text,
                                    lastName: lastName.text,
                                    addressLineOne: addressLineOne.text,
                                    addressLineTwo: addressLineTwo.text,
                                    city: city.text,
                                    zipCode: zipCode.text,
                                    contactNumber: contactNumber.text,
                                  ));
                              /* Navigator.of(context).pushNamedAndRemoveUntil(
                                AppRouter.mainscreen,
                                ModalRoute.withName(''),
                              );*/
                            }
                          }
                        },
                        child: Text(
                          widget.deliveryInfo == null
                              ? 'Add Address'
                              : 'Edit Address',
                          style: AppText.h3b?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    Space.yf(2)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
