#include <iostream>
#include <fstream>
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>

#include "Ui.h"
#include "Core.h"
#include "Store.h"
#include "ObjectBuilder.h"
#include "ObjectStore.h"
#include "MessageCentre.h"


//@@@Requires updating on addition on new subsystem" when adding new subsystems
Core::Core(std::string coreConfigFileName)
{

    //grab config file names
    boost::property_tree::ptree tree;
    read_xml(coreConfigFileName, tree);
    std::string storeConfigFileName = tree.get<std::string>("File.Store");
    std::string uiConfigFileName = tree.get<std::string>("File.Ui");

    //create bolt-ins
    store_ = new Store(this, storeConfigFileName);
    objectBuilder_ = new ObjectBuilder(this);
    objectStore_ = new ObjectStore(this);
    messageCentre_ = new MessageCentre(this);
    ui_ = new Ui(this, uiConfigFileName);


    //create subsystems
    healthSub_ = new System<HealthComp>(this);
    nameSub_ = new System<NameComp>(this);
    coordsSub_ = new System<CoordsComp>(this);
    moveSub_ = new System<MoveComp>(this);

}



Store* Core::getStore()
{
    return store_;
}



ObjectBuilder* Core::getObjectBuilder()
{
    return objectBuilder_;
}



ObjectStore* Core::getObjectStore()
{
    return objectStore_;
}



MessageCentre* Core::getMessageCentre()
{
    return messageCentre_;
}



Ui* Core::getUi()
{
    return ui_;
}



System<HealthComp>* Core::getHealthSub()
{
    return healthSub_;
}


System<NameComp>* Core::getNameSub()
{
    return nameSub_;
}


System<CoordsComp>* Core::getCoordsSub()
{
    return coordsSub_;
}


System<MoveComp>* Core::getMoveSub()
{
    return moveSub_;
}
