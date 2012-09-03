#include "Systems.h"
#include "MoveComp.h"
#include <iostream>

template <>
void System<MoveComp>::update(double elapsed)
{
    std::cout << "Updating MoveComps" << std::endl;

    //update all health components
    std::map<ObjectId,MoveComp>::iterator iCom = components_.begin();
    while(iCom!=components_.end())
    {
        MoveComp* currComponent = &iCom->second;



        ++iCom;
    }


}


template <>
void System<MoveComp>::deliverMessage_(Message message)
{
    std::cout << "Delivering message to MoveComps" << std::endl;
    //check if target entity is registered with this subsystem
    MoveComp* targetComponent = getComponent(message.getSourceId());
    if(targetComponent==NULL)
    {
        return;
    }

    Parameters params = message.getParameters();

    //read message!
    std::string mainCmd = params[1];

//    if (mainCmd=="changeMaxBy")
//    {
//        targetComponent->setMax(targetComponent->getMax() + atoi(params[2].c_str()));
//    }
//
//    else if (mainCmd=="changeCurrBy")
//    {
//        targetComponent->setCurrent(targetComponent->getCurrent() + atoi(params[2].c_str()));
//    }


}
